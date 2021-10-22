class CommentsController < ApplicationController
  def create
    @comment = Comment.new params.require(:comment).permit(:body)
    @post = Post.find params[:post_id]
    @comment.post = @post
    @comment.save
   
    redirect_to post_path(@post)
    
      # flash[:alert] = @comment.errors.full_messages.join(', ')
      # redirect_to post_path(@post)
    
  end

  def destroy
    @comment = Comment.find params[:id]
    @post = Post.find params[:post_id]
    
    if @comment.destroy
      flash[:notice] = "Comment deleted"
      redirect_to post_path(@post)
    else
    end
  end


end
