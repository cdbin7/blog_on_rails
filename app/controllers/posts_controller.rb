class PostsController < ApplicationController


  def index
    @posts = Post.all.order(created_at: :desc)
  end
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new params.require(:post).permit(:title, :body)
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show
    @post = Post.find params[:id]
    @comment = Comment.new
    @comments = @post.comments.all
  end

  def destroy
    @post = Post.find params[:id]
    if @post.destroy
      redirect_to posts_path
    else
      render :show
    end
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    @post = Post.find params[:id]

    if @post.update params.require(:post).permit(:title, :body)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  
end
