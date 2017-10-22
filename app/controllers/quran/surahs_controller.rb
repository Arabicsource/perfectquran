# frozen_string_literal: true

module Quran
  # :nodoc:
  class SurahsController < Quran::BaseController
    def index
      @surahs = Surah.all
      render layout: 'fullpage'
    end

    def show
      @surah = if params[:permalink].nil?
                 Surah.find(params[:id])
               else
                 Surah.find_by(permalink: params[:permalink])
               end
    end
  end
end
