# frozen_string_literal: true

module Manage
  # :nodoc:
  class PostsController < Manage::BaseController
    def index
      @posts = Post.all
    end

    def show
      @post = Post.find(params[:id])
    end

    def new
      @post = Post.new
    end

    def create
      @post = Post.new(post_params)
      @post.user = current_user

      if @post.save
        flash[:success] = t 'manage.post.created'
        redirect_to manage_posts_path
      else
        render :new
      end
    end

    def edit
      @post = Post.find(params[:id])
    end

    def update
      @post = Post.find(params[:id])

      if @post.update_attributes(post_params)
        flash[:success] = t 'manage.post.edited'
        redirect_to manage_posts_path
      else
        render :edit
      end
    end

    private def post_params
      params.require(:post).permit(:title, :content, :category_id)
    end
  end
end
