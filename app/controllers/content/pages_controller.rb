# frozen_string_literal: true

module Content
  # :nodoc:
  class PagesController < Content::BaseController
    def show
      @page = Page.find(params[:id])
    end
  end
end
