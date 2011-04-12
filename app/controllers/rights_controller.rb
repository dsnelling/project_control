
class RightsController < ApplicationController

  before_filter :check_authentication, :check_authorisation

# -- standard CRUD methods

  def index
    @rights = Right.find(:all)
  end

  def new
    @right = Right.new
  end

  def edit
    @right = Right.find(params[:id])
  end

  def show
    @right = Right.find(params[:id])
  end

  def create
    @right = Right.new(params[:right])
	if @right.save
	  flash[:notice] = "Right was successfully created!"
	  redirect_to(@right)
    else
	  render :action => "new"
	end
  end

  def update
    @right = Right.find(params[:id])
	if @right.update_attributes(params[:right])
	  flash[:notice] = "Right updated"
	  redirect_to (@right)
	else
	  render :action => "edit"
	end
  end

  def destroy
    @right = Right.find(params[:id])
	@right.destroy
	redirect_to rights_url
  end

# allocated rights to roles

  def roles
    @roles = Role.find(:all)
	@rights = Right.find(:all, :order => "name").map {|r| [r.name, r.id] }
  end

  # remove right from role
  def remove_right
    role = Role.find(params[:role_id])
	right = Right.find(params[:id])
	role.rights.delete(right)
	redirect_to roles_rights_url
  end

  # add the right to role
  def add_right
    role = Role.find(params[:id])
	right = Right.find(params[:right_id])
    role.rights << right
    redirect_to roles_rights_url

  end

end
