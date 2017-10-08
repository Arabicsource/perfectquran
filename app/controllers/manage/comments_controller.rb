# frozen_string_literal: true

module Manage
  # :nodoc:
  class CommentsController < Manage::BaseController
    def index
      @comments = Comment.all
    end

    def show
      @comment = Comment.find(params[:id])
    end

    def destroy
      @comment = Comment.find(params[:id])
      @comment.delete
      flash[:success] = t 'manage.comment.deleted'
      redirect_to manage_comments_path
    end
  end
end
