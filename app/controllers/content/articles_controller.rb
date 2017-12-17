# frozen_string_literal: true

module Content
  # :nodoc:
  class ArticlesController < ApplicationController
    def index
      @articles = Article.includes(:category, :account)
                         .where(collection: 'post', visibility: 'published')
    end

    def show
      @article = Article.find_by!(
        permalink: params[:id], visibility: 'published'
      )
      @comment = Comment.new
    end
  end
end
