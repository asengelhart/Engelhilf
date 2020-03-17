class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to user_path(logged_in_user)
    else
      redirect_to login_path
    end
  end

  def create
  end

  def destroy
  end
end
