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

  def edit
    admin_only
    @user = User.find_by(id: params[:id])
    return show_error("User not found") if @user.nil?
    @show_admin_option = true
  end

  def create
    @user = User.new(user_params)
    @user.is_admin = params[:user][:is_admin] if admin_logged_in?
    validate_user(@user) do
      render :new
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.update(user_params)
    validate_user(@user) do
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def validate_user(user)
    if user.valid?
      user.save
      session[:user_id] = user.id unless admin_logged_in?
      redirect_to user_path(user)
    else
      flash[:alert] = user.errors.full_messages
      yield
    end
  end
end
