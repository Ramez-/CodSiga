class RepliesController < ApplicationController
  before_action :set_reply, only: [:show, :edit, :update, :destroy]
  before_action :get_post_comment
  before_action :check, only: [:edit ,:update , :destroy]
  # GET /replies
  # GET /replies.json
  def index
    @replies = @comment.replies
  end

  # GET /replies/1
  # GET /replies/1.json
  def show
  end

  # GET /replies/new
  def new
      redirect_to @post , notice: "Please Log in to reply to a comment" if session[:user_id].blank?
      false
    @reply = @comment.replies.new
  end

  def get_post_comment
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:comment_id])
  end

  # GET /replies/1/edit
  def edit
  end

  def check
    if(session[:user_id] != @reply.user_id)
       redirect_to users_path , notice: "You can't edit a reply that you didnt post"
       false
    end
  end

  # POST /replies
  # POST /replies.json
  def create
    @reply = @comment.replies.new(reply_params)
    @reply.user_id = session[:user_id]
    respond_to do |format|
      if @reply.save
        format.html { redirect_to @post, notice: 'Reply was successfully created.' }
        format.json { render @post, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /replies/1
  # PATCH/PUT /replies/1.json
  def update
    respond_to do |format|
      if @reply.update(reply_params)
        format.html { redirect_to @reply, notice: 'Reply was successfully updated.' }
        format.json { render @post, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /replies/1
  # DELETE /replies/1.json
  def destroy
    @reply.destroy
    respond_to do |format|
      format.html { redirect_to @post, notice: 'Reply was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reply
      @post = Post.find(params[:post_id])
      @comment = @post.comments.find(params[:comment_id])
      @reply = @comment.replies.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reply_params
      params.require(:reply).permit(:content)
    end
end
