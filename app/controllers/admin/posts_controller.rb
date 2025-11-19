class Admin::PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @new_post = Post.new
    @post_comment = PostComment.new 
  end
  
private
      
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
    
  def post_params
    params.require(:post).permit(:title, :body, post_images: [])
  end
  
end
