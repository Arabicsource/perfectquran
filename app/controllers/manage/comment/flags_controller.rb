module Manage
  module Comment
    class FlagsController < Manage::BaseController
      def index
        @comments = ::Comment.joins(:flag)
      end
    end
  end
end