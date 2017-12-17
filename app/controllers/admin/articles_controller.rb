# frozen_string_literal: true

module Admin
  # :nodoc:
  class ArticlesController < Admin::BaseController
    def index
      @articles = Article.all
    end

    def show
      @article = Article.find(params[:id])
    end

    def new
      @article = Article.new
    end

    def create
      @article = Article.new(article_params)
      @article.account = current_account

      if @article.save
        flash[:success] = I18n.t 'article_created', title: @article.title
        redirect_to admin_articles_path
      else
        render :new
      end
    end

    def edit
      @article = Article.find(params[:id])
    end

    def update
      @article = Article.find(params[:id])

      if @article.update_attributes(article_params)
        flash[:success] = I18n.t(
          'admin.articles.update.success_notification', title: @article.title
        )
        redirect_to admin_articles_path
      else
        render :edit
      end
    end

    def destroy
      @article = Article.find(params[:id])
      @article.visibility = 'trash'
      @article.save
      flash[:success] = I18n.t(
        'admin.articles.destroy.success_notification', title: @article.title
      )
      redirect_to admin_articles_path
    end

    private

    def article_params
      params.require(:article)
            .permit(:title, :content, :visibility, :collection, :category_id)
    end
  end
end
