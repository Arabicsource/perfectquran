# frozen_string_literal: true

module Blog
  # :nodoc:
  class PostsController < Blog::BaseController
    def index
      @posts = Post.includes(:category, :user).order('created_at DESC')
    end

    def show
      @post = Post.find_by(permalink: params[:id])
      @comment = Comment.new
    end
  end
end
