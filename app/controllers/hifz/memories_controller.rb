# frozen_string_literal: true

module Hifz
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
      if resource == 'pages'
        klass = "Quran::#{resource.singularize.classify}"
      else
        klass = resource.singularize.classify
      end

      @memorable = klass.constantize.find(id)
    end
  end
end
