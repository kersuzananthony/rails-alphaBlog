class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_anonymous, only: [:new, :create]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to Alpha Blog #{@user.username}!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @user.update(user_params)
      flash[:success] = 'Your account was updated successfully!'
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:danger] = 'User and all articles by user have been deleted.'
    redirect_to users_path
  end

  # Private methods
  private
  def user_params
    # Whitelist some user fields
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:danger] = 'You can only edit your own profile'
      redirect_to user_path(current_user)
    end
  end

  def require_admin
    if logged_in? && !current_user.admin?
      flash[:danger] = 'Only admin users can perform that action'
      redirect_to users_path
    end
  end

end