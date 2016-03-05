class ArticlesController < ApplicationController

  # Before Show, edit, update, destroy actions, set_article private method is called
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    @article.user = User.first # hard code User for the moment
    if @article.save
      # Successfully saved the article, redirect to show method
      flash[:success] = 'Article was successfully created!'
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:success] = 'Article was successfully updated!'
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    flash[:danger] = 'Article was successfully deleted!'
    redirect_to articles_path
  end

  private
  def article_params
    # Whitelist some article fields
    params.require(:article).permit(:title, :description)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end