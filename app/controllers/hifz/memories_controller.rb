# frozen_string_literal: true

module Hifz
  # :nodoc:
  class MemoriesController < ApplicationController
    before_action :load_memorable

    def create
      if @memorable.memorize
        flash[:success] = 'Alhamdulillah'
      else
        flash[:info] = 'You must be logged in to record memories'
      end

      redirect_back(fallback_location: hifz_root_url)
    end

    private

    def load_memorable
      resource, id = request.path.split('/')[2, 3]
      @memorable = resource.singularize.classify.constantize.find(id)
    end
  end
end
