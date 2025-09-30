class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images
  end

  def edit
  end

  def mypage
    @user = User.find(params[:id])
    @post_images = @user.post_images
  end
end
