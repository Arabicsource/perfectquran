# frozen_string_literal: true

module Admin
  class ArticlesController < Admin::BaseController
    def index
      @resources = Article.all
    end

    def show
      @resource = Article.find(params[:id])
    end

    def new
      @resource = Article.new
    end

    # rubocop:disable Metrics/MethodLength
    def create
      @resource = Article.new(article_params)
      @resource.account = current_account

      if @resource.save
        flash[:success] = 'Alhamdulillah, the article was added'
        redirect_to admin_articles_path
      else
        respond_to do |format|
          format.html { render :new, status: 422 }
          format.js
        end
      end
    end
    # rubocop:enable Metrics/MethodLength

    def edit
      @resource = Article.find(params[:id])
    end

    def update
      @resource = Article.find(params[:id])

      if @resource.update_attributes(article_params)
        flash[:success] = 'Alhamdulillah, the article was updated'
        redirect_to admin_articles_path
      else
        respond_to do |format|
          format.html { render :edit, status: 422 }
          format.js
        end
      end
    end

    def destroy
      @resource = Article.find(params[:id])

      if can_be_deleted? && @resource.delete
        flash[:success] = 'Alhamdulillah, the article was deleted'
        redirect_to admin_articles_path
      else
        flash.now[:danger] = 'The article was not deleted'
        render :show, status: 422
      end
    end

    private

    def article_params
      params.require(:article)
            .permit(:title, :content, :visibility, :collection, :category_id)
    end

    def can_be_deleted?
      @resource.comments.empty?
    end
  end
end
