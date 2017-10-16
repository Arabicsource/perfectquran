# frozen_string_literal: true

# :nodoc:
class CommentsController < ApplicationController
  before_action :authenticate_user!, :load_commentable
  
  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    
    if @comment.save
      flash[:success] = t 'comment.created'
      redirect_to @commentable.redirect_path
    end
  end

  private 
  
  def comment_params
    params.require(:comment).permit(:content)
  end

  def load_commentable
    resource, id = request.path.split('/')[1,2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end
end
