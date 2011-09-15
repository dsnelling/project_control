# allows Roles to be managed. not full functionality, as does not
# create or destry roles. allows roles allocation to user to be updated
#
class RolesController < ApplicationController
  before_filter :find_user, :except => :create
  before_filter :check_authentication, :check_authorisation

  #GET users/:id/roles
  def index
    @roles = Role.all
    @roles_of_user = @user.roles.all
    if !@roles_of_user.empty?
      @roles_not_of_user = Role.where(["id NOT IN (?)",@roles_of_user] )
    else
      @roles_not_of_user = @roles
    end
	@role = Role.new
  end

  #def show
  #  @role = Role.find(params[:id])
  #end

  #def new
  #  @role = Role.new
  #end

  #def edit
  #  @role = Role.find(params[:id])
  #end

  def create
    @role = Role.new(params[:role])
	if @role.save
	  flash[:notice] = "Role sucessfully created..!"
	  redirect_to users_path # not really the right place to redirect to
	                         # but we've lost the id of the current user
	else
	  render :action => "new"
	end
  end

  def update
    @role = Role.find(params[:id])
	if @role.update_attributes(params[:role])
	  flash[:notice] = "Role sucessfully updated ...!"
	  redirect_to @role
	else
	  render :action => "edit"
	end
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
