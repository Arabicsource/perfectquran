# frozen_string_literal: true

module Quran
  class SurahsController < ApplicationController
    def index
      @surahs = Quran::Surah.all
    end

    def show
      if params[:permalink].nil?
        surah = Quran::Surah.find(params[:id])
        return redirect_to "/quran/#{surah.permalink}"
      end

      @surah = Quran::Surah.find_by(permalink: params[:permalink])

      render layout: 'quran'
    end
  end
end
