class ApplicationController < ActionController::Base
    include SessionsHelper
    
    # before_filter :authenticate_user!
    
    # private
    # def require_login
    # unless current_user
    #   redirect_to new_session_path
    # end
end
