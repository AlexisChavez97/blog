class SessionsController < ApplicationController
  def new
    binding.pry
  end

  def create
    binding.pry
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You have succesfully logged in"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Wrong info"
      render 'new'
    end
  end

  def destroy
    binding.pry
    session[:user_id] = nil
    flash[:success] = "You have succesfully logged out"
    render 'new'
  end
end
