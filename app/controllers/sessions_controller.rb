class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create_by_oauth2
    if auth['uid']
      user = User.find_or_create_by(uid: auth['uid']) do |u|
        u.email = auth['info']['email']
        u.name = auth['info']['name']
        u.password = SecureRandom.hex
      end
      if user.valid?
        session[:user_id] = user.id
        redirect_to user_path(logged_in_user)
      else
        flash[:alert] = "There was a problem logging in."
        redirect_to login_path
      end
    end
  end

  def destroy
    session.delete :user_id
    redirect_to login_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
