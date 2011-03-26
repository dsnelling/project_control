# main_menu controller - provides the top level access to the application.
# also allows the default project to be set for the current session
#
# no need for authentication for this controller
class MainMenuController < ApplicationController
  
  # this index page is the default home page for the application
  def index
    @projects = Project.find(:all, :order =>"name").map {|p| [p.description, p.name]}
	if session[:user_id]
      @name = User.find(session[:user_id]).forename
	else
	  @name = " "
	end
  end

  # the 'about' page serves a static page about the application
  def about
  end

  # set the project number
  def set_project
    if request.post?
      session[:project] = params[:project] if params[:project]
	  redirect_to :action => :index
    end
  end

end
