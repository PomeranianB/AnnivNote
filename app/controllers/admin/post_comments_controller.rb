class Admin::PostCommentsController < ApplicationController
  layout 'admin' 
  before_action :authenticate_admin!

  def index
    @post_comments = PostComment.all
    @users = User.all
  end

  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    redirect_to admin_post_comments_path
  end

  private


  def post_params
    params.require(:post).permit(:title, :body, post_images: [])
  end

end
