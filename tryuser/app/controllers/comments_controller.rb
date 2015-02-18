class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :check , only:[:edit, :update, :destroy]
  before_action :get_post
  # GET /comments
  # GET /comments.json
  def index
    @comments = @post.comments
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  def get_post
   @post = Post.find(params[:post_id])
  end
  # GET /comments/new
  def new
    if session[:user_id].blank?
      redirect_to @post , notice: "Please Log in to comment"
      false
    end
    @comment = @post.comments.new
  end

  def check
    if(session[:user_id] != @comment.user_id)
       redirect_to users_path , notice: "You Must be logged in to edit your account"
       false
    end
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @post.comments.new(comment_params)
    @comment.user_id = session[:user_id]
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post , notice: 'Comment was successfully created.' }
        format.json { render @post , status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @post , notice: 'Comment was successfully updated.' }
        format.json { render @post , status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @post, notice: 'Comment was successfully destroyed.' }
      format.json { redirect_to @post , status: :ok , location: @post }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @post = Post.find(params[:post_id])
      @comment = @post.comments.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content)
    end
end
