class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @topic = Topic.find(params[:topic_id])
    @comment = @topic.comments.build(comment_params)
    @comment.user = current_user    

    if @comment.save
      flash[:success] = t 'comment.created'
      redirect_to @topic
    else
      render 'topics/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end