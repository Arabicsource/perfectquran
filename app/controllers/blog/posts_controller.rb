# frozen_string_literal: true

module Blog
  # :nodoc:
  class PostsController < Blog::BaseController
    def index
      @posts = Post.all
    end
  end
end
