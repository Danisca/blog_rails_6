class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?
  def current_user
     @current_user ||= User.find(session[:user_id]) if session[:user_id]
     #byebug
  end

  def logged_in?
    #this convert a method to a boolean type 
    !!current_user
  end

  def require_user 
    #this convert a method to a boolean type 
    if !logged_in?
      flash[:error] = "Error you have to be logged in to perform that action"
      redirect_to login_path
    end
  end
end
