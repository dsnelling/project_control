# control to administer users
# (may do the roles here, or have a separate contoller!)
# also does the login screen from here
class UsersController < ApplicationController
  skip_before_filter :check_authentication, :only => :login
  before_filter :check_authentication, :except => :login
  before_filter :check_authorisation, :except => [:login,
       :logout, :change_password, :index]

  #default action is the listing of all users
  def index
    @all_users = User.order("username")
  end


  def login
    @projects = Project.order("name").map {|p| [p.description, p.name] } 
	if request.post?
	  user = User.authenticate(params[:username], params[:password])
	  if user
	    session[:user_id] = user.id
		session[:username] = user.username
		session[:project] = params[:project] if params[:project]
		user.update_attribute(:last_login, Time.now)
        flash[:notice] = user.username + " logged in ..!"
        redirect_to main_menu_path
	  else
	    flash[:notice] = "Invalid user/password!!"
	  end
	end
  end


  #logout
  def logout
    name = User.find(session[:user_id]).username
    session[:user_id] = nil
	session[:username] = session[:locale] = session[:project] = nil
	# purge session variables
	session_count = ActiveRecord::SessionStore::
	Session.delete_all( [ 'updated_at < ?', 1.day.ago])
	flash[:notice] = name +
	   " Logged out!!!; #{session_count} Sessions purged .. "
    redirect_to(:action => :login)
  end

  def change_password
    @this_user = User.find(session[:user_id])
    if request.post?
	  #superuser can change anyone's password
	  if @this_user.superuser
		if !@user = User.find_by_username(params[:username])
		  flash[:notice] = "Username not found"
		  return
		end
	  else
	    @user = User.authenticate(session[:username], params[:old_password])
	  end
	  if ((@this_user.superuser || @user) &&
	          params[:new_password] == params[:confirm_password])
	    @user.password= params[:new_password]
		if @user.save
		  flash[:notice] = "Password successfully updated ... for " +
		    @user.username
		  redirect_to(:action => :index)
		  return
		end
	  end
	flash[:notice] = "Password not updated"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
	if @user.save
	  flash[:notice] = 'User was successfully created'
	  redirect_to(@user)
	else
	  render :action => "new"
	end
  end
 
  def update
    @user = User.find(params[:id])
	if @user.update_attributes(params[:user])
	  flash[:notice] = "User was successfully updated!"
	  redirect_to(@user)
	else
	  render :action => "edit"
	end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
	redirect_to users_url
  end

end
