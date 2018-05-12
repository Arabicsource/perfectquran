# frozen_string_literal: true

module Quran
  class SurahsController < ApplicationController
    def index
      @surahs = Quran::Surah.all
    end

    def show
      @surah = Quran::Surah.find_by(permalink: params[:permalink])

      render layout: 'quran'
    end
  end
end
