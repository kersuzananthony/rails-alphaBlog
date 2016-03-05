class CategoriesController < ApplicationController

  before_action :set_category, only: [:show]
  before_action :require_admin, only: [:new, :create]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def show
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)
    if @category.save
      flash[:success] = 'You successfully created a new category.'
      redirect_to categories_path
    else
      render 'new'
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !logged_in? || (logged_in? && !current_user.admin?)
      flash[:danger] = 'Only admin can peform this action.'
      redirect_to categories_path
    end
  end

  def set_category
    @category = Category.find(params[:id])
  end

end