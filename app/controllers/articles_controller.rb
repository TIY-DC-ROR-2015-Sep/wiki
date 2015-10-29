class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find params[:id]
  end

  def edit
    @article = Article.find params[:id]
  end

  def update
    @article = Article.find params[:id]
    begin
      current_user.edit @article, params[:article][:body]
      redirect_to @article, notice: "Article saved"
    rescue ActiveRecord::RecordInvalid
      render :edit
    end
  end
end
