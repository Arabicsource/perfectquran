class FlagsController < ApplicationController
  def new
    @comment = Comment.find(params[:comment_id])
    @flag = Flag.new
  end

  def create
    params[:flag][:ip_address] = request.ip
    @comment = Comment.find(params[:comment_id])
    @flag = @comment.build_flag(flag_params)
    @flag.user = current_user if user_signed_in?
    @flag.save
    flash[:success] = t 'comment.flagged'
    redirect_to blog_post_path(@comment.commentable.permalink)
  end

  private

  def flag_params
    params.require(:flag).permit(:ip_address, :content)
  end
end