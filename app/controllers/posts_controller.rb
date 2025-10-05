class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def index
    @posts = Post.all
    @post = Post.new
    @user = User.find(current_user.id)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @new_post = Post.new

  end

  def edit
  end

  
private

  def post_params
    params.require(:post).permit(:title, :body, :images)
  end

end
