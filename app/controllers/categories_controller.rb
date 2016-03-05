class CategoriesController < ApplicationController

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def show

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

end