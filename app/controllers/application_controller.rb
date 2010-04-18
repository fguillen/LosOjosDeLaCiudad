# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  filter_parameter_logging :password
  helper_method :admin?
  
  private
    def require_admin
      puts "require_admin, session[:admin].nil?: #{session[:admin].nil?}"
      unless session[:admin]
        redirect_to cameras_path
        return false
      end
    end
    
    def admin?
      return( !session[:admin].nil? )
    end
end
