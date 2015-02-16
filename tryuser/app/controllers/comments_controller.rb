class CommentsController < ApplicationController
	def index
		@c = Comment.all;
	end

	def new
		@c = Comment.new
	end

	def show
		@c = Comment.find(params[:id])
	end

	def create
		@c = Comment.new(comment_params)
		if @c.save
			redirect_to comments_path , notice: "Your Comment Was Saved"
		else
			render "new"
		end
	end

	def edit
		@c = Comment.find(params[:id])
	end

	def update
		@c = Comment.find(params[:id])
		if @c.update(comment_params)
			redirect_to comments_path , notice: "Your Comment was edited sucessfully"
		else
			render "edit"
		end
	end

	def destroy
		@c = Comment.find(params[:id])
		@c.destroy
		redirect_to comments_path , notice: "Your Comment Has Been Deleted"
	end

	private
	def comment_params
		params.require(:comment).permit(:content)
	end

end