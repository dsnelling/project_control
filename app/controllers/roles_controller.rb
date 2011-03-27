# allows Roles to be managed. not full functionality, as does not
# create or destry roles. allows roles allocation to user to be updated
#
class RolesController < ApplicationController
  before_filter :find_user
  before_filter :check_authentication, :check_authorisation

  def index
    @roles = Role.find(:all)
    @roles_of_user = @user.roles.find(:all)
    if !@roles_of_user.empty?
      @roles_not_of_user = Role.find(:all, :conditions => ["id NOT IN (?)",
        @roles_of_user] )
    else
      @roles_not_of_user = @roles
    end
  end

  def create
  end

  def add_role_to_user
    role = Role.find(params[:id])
    @user.add_role(role)
	redirect_to(user_roles_path(@user_id))
  end

  def remove_role_from_user
    role = Role.find(params[:id])
    @user.remove_role(role)
	redirect_to(user_roles_path(@user_id))
  end

  private

  def find_user
  @user_id = params[:user_id]
  redirect_to users_path unless @user_id
  @user = User.find(@user_id)
  end

end
