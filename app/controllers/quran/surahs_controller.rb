# frozen_string_literal: true

module Quran
  class SurahsController < ApplicationController
    def index
      @surahs = Quran::Surah.all
    end

    def show
      if params[:permalink].nil?
        return render(file: "#{Rails.root}/public/404.html",
                      status: 404, layout: false)
      end

      @surah = Quran::Surah.find_by(permalink: params[:permalink])

      render layout: 'quran'
    end
  end
end
