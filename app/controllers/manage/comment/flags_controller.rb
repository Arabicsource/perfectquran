module Manage
  module Comment
    class FlagsController < Manage::BaseController
      def index
        @comments = ::Comment.joins(:flag)
      end

      def update
        @flag = Flag.find(params[:id])
        @flag.toggle!(:approved)
        flash[:success] = t 'manage.comment.approved'
        redirect_to manage_comment_path(@flag.comment)
      end
    end
  end
end