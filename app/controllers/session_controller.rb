class SessionController < ApplicationController

  # Display login form
  def new

  end

  # When user post login credentials
  def create
    # comment
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      flash[:success] = "Welcome back #{user.username}!"
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      # Credentials incorrect
      flash.now[:danger] = 'Invalid credentials, please try again'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'You have logged out'

    redirect_to root_path
  end
end
