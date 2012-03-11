class SessionsController < ApplicationController
  def create
    Rails.logger.info auth_hash.to_hash.inspect
    @user = User.fetch_by_auth_hash auth_hash
    session[:user_id] = @user.id

    return redirect_to root_url
  end

  # clear the session variable
  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  protected
  def auth_hash
    request.env['omniauth.auth']
  end
end
