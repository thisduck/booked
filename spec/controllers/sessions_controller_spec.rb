require 'spec_helper'

describe SessionsController do

  describe "GET 'create'" do
    let (:auth_key) { "twitter-123545" }
    before do 
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
    end

    it "creates new account on new login" do
      expect {
        visit '/auth/twitter'
      }.should change(User, :count).by 1
    end

    it "redirects after auth" do
      visit '/auth/twitter'
      current_path.should == root_path
    end

    it "logs in existing user" do
      user = FactoryGirl.create(:user, :auth_keys => [auth_key])
      expect {
        visit '/auth/twitter'
      }.should change(User, :count).by 0
    end
  end

  describe "'destroy'" do
    before :each do 
      session[:user_id] = BSON::ObjectId.new
    end

    it "should log out the user on get" do
      get 'destroy'
      session[:user_id].should be_nil
      response.should redirect_to root_url
    end

    it "should log out the user on post" do
      post 'destroy'
      session[:user_id].should be_nil
      response.should redirect_to root_url
    end
  end
end
