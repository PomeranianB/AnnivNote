class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc).limit(3)
    @post = Post.new
    @latest_comments = PostComment.order(created_at: :desc).limit(3)    
    @post_comment = PostComment.includes(:post, :user).all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_dashboards_path, notice: 'ユーザーを削除しました。'
  end

  private
    
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
    
  def post_params
    params.require(:post).permit(:title, :body, post_images: [])
  end

end
