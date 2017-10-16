class FlagsController < ApplicationController
  def new
    @comment = Comment.find(params[:comment_id])
    @flag = Flag.new
  end

  def create
    @comment = Comment.find(params[:comment_id])
    @flag = @comment.build_flag(flag_params)
    @flag.user = current_user if user_signed_in?

    if @flag.save
      flash[:success] = t 'comment.flagged'
      redirect_to @comment.commentable.redirect_path
    end
  end

  private

  def flag_params
    params[:flag][:ip_address] = request.ip    
    params.require(:flag).permit(:ip_address, :content)
  end
end