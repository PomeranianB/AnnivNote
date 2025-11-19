class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:favorites]
  
  def index
    @user = User.find(current_user.id)
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(3)
    @post = Post.new
  end

  def edit
    @user = User.find(current_user.id)
  end

  def mypage
    @user = User.find(current_user.id)
    @posts = @user.posts.order(created_at: :desc).limit(3)
    @post = Post.new
    @latest_comments = @user.post_comments.order(created_at: :desc).limit(3)    
    @post_comment = PostComment.includes(:post, :user).all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(6)
    @post = Post.new
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "アップデートが完了しました"
      redirect_to mypage_path(current_user.id)
    else
      render :edit
     end
  end

  def unsubscribe
    @user = User.find_by(params[:id])
  end

  def withdraw
		@user = User.find(current_user.id)
		#is_deletedカラムにフラグを立てる(defaultはtrue)
    	@user.update(is_valid: false)
    	#ログアウトさせる
    	reset_session
    	flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    	redirect_to new_user_registration_path
	end

  private
    
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
    
  def post_params
    params.require(:post).permit(:title, :body, post_images: [])
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

end
