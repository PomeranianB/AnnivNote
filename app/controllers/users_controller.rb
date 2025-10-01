class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_images = @user.user_images
  end

  def edit
  end

  def mypage
  end

  private
    
  def user_params
    params.require(:user).permit(:name, :user_image, :introduction)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
end
