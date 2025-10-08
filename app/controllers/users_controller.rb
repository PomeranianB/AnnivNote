class UsersController < ApplicationController
  
  def show
    @user = User.find(current_user.id)
    @posts = @user.posts
    @post = Post.new
  end

  def edit
    @user = User.find(current_user.id)
  end

  def mypage
    @user = User.find(current_user.id)
    @posts = @user.posts
    @post = Post.new
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "アップデートが完了しました"
      redirect_to user_path(@user)
    else
      render :edit
     end
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
