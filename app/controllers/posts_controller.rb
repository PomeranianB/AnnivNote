class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  .def index
    @posts = Post.with_active_user.order(created_at: :desc).page(params[:page]).per(6)
    @post = Post.new
    @post_comment = PostComment.new
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @new_post = Post.new
    @post_comment = PostComment.new 
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user == current_user
        render "edit"
    else
        redirect_to posts_path
    end
  end
    
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params) 
      redirect_to :post, notice: "更新されました"
    else
      render :edit # バリデーションエラーの場合、editビューを表示する
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
      flash[:notice] = "投稿が削除されました"
      redirect_to mypage_path
  end
  
private

  def post_params
    params.require(:post).permit(:title, :body, post_images: [])
  end

end
