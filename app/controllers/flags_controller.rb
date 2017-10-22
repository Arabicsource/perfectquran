# frozen_string_literal: true

# :nodoc:
class FlagsController < ApplicationController
  def new
    @comment = Comment.find(params[:comment_id])
    @flag = Flag.new
  end

  def create
    @comment = Comment.find(params[:comment_id])
    @flag = @comment.build_flag(flag_params)
    @flag.user = current_user if user_signed_in?

    flash[:success] = t 'comment.flagged' if @flag.save
    redirect_to redirect_path
  end

  private

  def flag_params
    params[:flag][:ip_address] = request.ip
    params.require(:flag).permit(:ip_address, :content)
  end

  def redirect_path
    if @comment.commentable.respond_to? :permalink
      blog_post_path(@comment.commentable.permalink)
    else
      quran_ayah_path(@comment.commentable)
    end
  end
end
