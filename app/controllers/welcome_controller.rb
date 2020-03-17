class WelcomeController < ApplicationController
  def home
    if logged_in?
      redirect_to user_path(logged_in_user)
    else
      redirect_to login_path
    end
  end
end
