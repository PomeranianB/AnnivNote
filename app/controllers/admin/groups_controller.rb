class Admin::GroupsController < ApplicationController
  layout 'admin' 
  before_action :authenticate_admin!

  def index
    @groups = Group.all
    @users = User.all
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to admin_groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image)
  end

end
