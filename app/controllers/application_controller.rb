class ApplicationController < ActionController::Base
  helper_method :logged_in_user

  def logged_in?
    session.include? :user_id
  end

  def logged_in_user
    User.find(session[:user_id])
  end

  def check_logged_in
    redirect_to login_path unless logged_in?
  end
end
