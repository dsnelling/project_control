# includes application wide methods to check authentications (ie is the user 
# logged in?) and authorisations (does the logged in user have the right to
# perform the requested action?). check_auth* filters are in individual
# controllers

# sets the locale based on locale set in the session

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.


# DS Mar-2011

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  layout "main"   # use the standard layout all the time

  # Scrub sensitive parameters from your log
  filter_parameter_logging :passworda
  before_filter :set_user_locale

private

  def check_authentication
    unless session[:user_id]
	  flash[:notice] = t('flash.auth_failed')
	  session[:intended_action] = action_name
	  session[:intended_controller] = controller_name
	  redirect_to (login_url)
	 
    end
  end

  def check_authorisation
    user = User.find(session[:user_id])
	unless user.superuser || user.roles.detect{|role|
	  role.rights.detect{|right|
	    right.action == action_name && right.controller == \
		   self.class.controller_path }
		}
	  flash[:notice] = t('flash.page_not_auth')
	  request.env["HTTP_REFERER"] ? (redirect_to :back) : 
	       (redirect_to(main_menu_url))
	  return false
    end
  end

  def set_user_locale
    session[:locale] = params[:locale] if params[:locale]
	I18n.locale = session[:locale] || I18n.default_locale
  end

end


