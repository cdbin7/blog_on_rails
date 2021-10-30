class PostsController < ApplicationController
  before_action :find_post, except: [:index, :new, :create]
  before_action :authenticated_user!, except: [:index, :show]
  before_action :authorize_user!, only: [:update, :destroy]

  def index
    @posts = Post.all.order(created_at: :desc)
  end
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new params.require(:post).permit(:title, :body)
    
    @post.user = current_user
    if @post.save
      flash[:notice] = "Post created successfully!"
      redirect_to post_path(@post)
    else
      render :new
      flash[:alert] = @post.errors.full_messages
    end
  end

  def show
    # @post = Post.find params[:id]
    @comment = Comment.new
    @comments = @post.comments.all
  end

  def destroy
    # @post = Post.find params[:id]
    if @post.destroy
      redirect_to posts_path
    else
      render :show
    end
  end

  def edit
    # @post = Post.find params[:id]
  end

  def update
    # @post = Post.find params[:id]

    if @post.update params.require(:post).permit(:title, :body)
      redirect_to post_path(@post)
    else
      render :edit
      flash[:alert] = @post.errors.full_messages
    end
  end

  private

  def find_post
    @post = Post.find params[:id]
  end

  def authorize_user!
    redirect_to root_path, alert: "Not Authorized!" unless can?(:crud, @post)
  end
  
end
