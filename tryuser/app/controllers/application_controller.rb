class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

helper_method :current_user , :is_auth
private

	def current_user
  		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def is_auth
 		@current_user_auth ||= User.find(session[:user_id]).is_auth if session[:user_id]
	end

end
