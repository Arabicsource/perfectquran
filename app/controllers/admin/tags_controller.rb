# frozen_string_literal: true

module Admin
  class TagsController < Admin::BaseController
    def index
      @tags = Tag.all
    end
  end
end
