# frozen_string_literal: true

module Study
  class SurahsController < ApplicationController
    def index
      @surahs = Quran::Surah.all
    end

    def show
      @surah = if params[:permalink].nil?
                 Quran::Surah.find(params[:id])
               else
                 Quran::Surah.find_by(permalink: params[:permalink])
               end
    end
  end
end
