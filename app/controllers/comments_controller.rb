# frozen_string_literal: true

# :nodoc:
class CommentsController < ApplicationController
  before_action :authenticate_user!, :load_commentable

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    flash[:success] = t 'comment.created' if @comment.save
    redirect_to redirect_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = if resource == 'ayahs'
                     Quran::Ayah.find(id)
                   else
                     resource.singularize.classify.constantize.find(id)
                   end
  end

  def redirect_path
    if @commentable.respond_to? :permalink
      blog_post_path(@commentable.permalink)
    else
      quran_ayah_path(@commentable)
    end
  end
end
