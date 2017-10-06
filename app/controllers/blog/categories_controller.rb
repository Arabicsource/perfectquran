# frozen_string_literal: true

module Blog
  # :nodoc:
  class CategoriesController < Blog::BaseController
    def show
      @category = Category.find(params[:id])
    end
  end
end
