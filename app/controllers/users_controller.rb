class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
  end

  def index
    admin_only
    @users = User.all
  end

  def new
    @user = User.new
    @show_admin_option = admin_logged_in?
  end

  def create
    user = User.new(user_params)
    user.is_admin = params[:user][:is_admin] if 
    if user.valid?
      user.save
      redirect_to user_path(user)
    else
      flash[:alert] = user.errors.full_messages
      render :new
    end
  end
end
