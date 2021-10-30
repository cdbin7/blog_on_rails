class CommentsController < ApplicationController
  before_action :find_comment, only: [:destroy]
  before_action :authenticated_user!
  before_action :authorize_user!, only: [:destroy]

  def create
    @comment = Comment.new params.require(:comment).permit(:body)
    @post = Post.find params[:post_id]
    @comment.post = @post
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@post)
    else
      @comments = @post.comments.order(created_at: :desc)
      render '/posts/show'
    end
        
  end

  def destroy
    # @comment = Comment.find params[:id]
    @post = Post.find params[:post_id]
    
    if @comment.destroy
      flash[:notice] = "Comment deleted"
      redirect_to post_path(@post)
    else
    end
  end

  private
  def find_comment
    @comment = Comment.find params[:id]
  end


  def authorize_user!
    redirect_to root_path, alert: "Not Authorized!" unless can?(:crud, @comment)
  end



end
