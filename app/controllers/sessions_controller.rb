class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user.authenticate(params[:password])
      log_in(@user)
      redirect_to user_path(@user)
    else
      flash[:alert] = "User credentials are invalid, please try again."
      render :new
    end
  end

  def create_by_oauth2
    if auth['uid']
      user = User.find_or_create_by(uid: auth['uid']) do |u|
        u.email = auth['info']['email']
        u.name = auth['info']['name']
        u.password = SecureRandom.hex
      end
      if user.valid?
        log_in(user)
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

  def log_in(user)
    session[:user_id] = user.id
  end 
end
