class ApplicationController < ActionController::Base
  def logged_in?
    session.include? :user_id
  end

  def logged_in_user
    User.find(session[:user_id])
  end
end
