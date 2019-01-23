class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show destroy]
  before_action :require_correct_user, only: %i[edit update destroy]
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.all
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome #{@user.username}"
      redirect_to user_path(@user)
      binding.pry
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = 'User successfully updated'
      redirect_to articles_path
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:danger] = "User was successfully deleted"
    redirect_to users_path
  end

  private

  def require_correct_user
    if current_user != @user && !current_user.admin?
      flash[:danger] = "You can only edit your own account"
      redirect_to root_path
    end
  end

  def set_user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def require_admin
    if logged_in? && !current_user.admin?
      flash[:danger] = "Only admin users can perform that action"
      redirect_to root_path
    end
  end
end
