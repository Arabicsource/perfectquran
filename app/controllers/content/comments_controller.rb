# frozen_string_literal: true

module Content
  class CommentsController < ApplicationController
    before_action :authenticate_account!

    def create
      @article = Article.find(params[:article_id])
      @comment = @article.comments.build(comment_params)
      @comment.account = current_account

      if @comment.save
        flash[:success] = I18n.t('content.comments.create.success_notification')
        redirect_to content_article_path(@article.permalink)
      else
        @article.comments = []
        render template: 'content/articles/show'
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:content)
    end
  end
end
