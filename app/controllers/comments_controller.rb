class CommentsController < ApplicationController
  before_filter do
    return redirect_to(root_url) if !logged_in?
    return redirect_to(root_url) if [:index, :new, :edit, :update, :destroy].include?(params[:action]) && !current_user.admin?

    if params.has_key? :entry_id
      @entry = Entry.find params[:entry_id].split("-").first
    end

    if params.has_key? :id
      @comment = @entry.comments.find params[:id]
    end
  end

  # GET /comments
  # GET /comments.json
  def index
    @comments = @entry.comments

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = @entry.comments.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @entry.comments.build(params[:comment])
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.entry, notice: 'Comment was successfully created.' }
        format.json { render json: { :comment => @comment, :html => render_to_string(:partial => @comment) }, status: :created, location: @comment.entry }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end
end
