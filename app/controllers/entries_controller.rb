class EntriesController < ApplicationController
  respond_to :html, :json
  before_filter do
    return redirect_to(root_url) if !logged_in?
    return redirect_to(root_url) if [:index, :new, :edit, :update, :destroy].include?(params[:action]) && !current_user.admin?

    if params.has_key? :id
      @entry = Entry.find params[:id].split("-").first
    end
  end

  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.all
    respond_with @entries
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    @random = Entry.random(@entry.id, current_user)
    respond_with @entry
  end

  # GET /entries/new
  # GET /entries/new.json
  def new
    @entry = Entry.new
    respond_with @entry
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(params[:entry])
    flash[:notice] =  'Entry was successfully created.' if @entry.save
    respond_with @entry
  end

  # PUT /entries/1
  # PUT /entries/1.json
  def update
    flash[:notice] =  'Entry was successfully updated.' if @entry.update_attributes(params[:entry])
    respond_with @entry
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_with @entry
  end

  def vote
    @vote = @entry.vote(current_user, params[:direction])
    respond_with @vote, location: nil
  end

  def comment
    @comment = @entry.comment(current_user, params[:comment][:body])
    respond_with({:comment => @comment}, :location => @entry)
  end

  def comments
    respond_with @entry.comments
  end
end
