# frozen_string_literal: true

module Blog
  # :nodoc:
  class CommentsController < Blog::BaseController
    before_action :authenticate_user!

    def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.new(comment_params)
      @comment.user = current_user

      if @comment.save
        flash[:success] = t 'blog.comment.created'
        redirect_to blog_post_path(@post.permalink)
      else
        render 'blog/posts/show'
      end
    end

    private def comment_params
      params.require(:comment).permit(:content)
    end
  end
end
