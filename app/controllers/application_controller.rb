class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about], unless: :admin_controller? 
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    mypage_path(current_user.id)
  end

  def after_sign_out_path_for(resource)
    about_path
  end

  private
 
  def admin_controller?
    self.class.module_parent_name == 'Admin'
  end

  def reset_guest_data
    guest_user = User.find_by(email: "guestuser@example.com")      
    guest_user.posts.destroy_all if guest_user.posts.any?
    guest_user.post_comments.destroy_all if guest_user.post_comments.any?
    guest_user.groups.destroy_all if guest_user.groups.any?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end