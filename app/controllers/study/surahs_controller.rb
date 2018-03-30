# frozen_string_literal: true

module Study
  class SurahsController < ApplicationController
    def index
      @surahs = Quran::Surah.all

      respond_to do |format|
        format.html
        format.json { render json: @surah }
      end
    end

    def show
      @surah = if params[:permalink].nil?
                 Quran::Surah.find(params[:id])
               else
                 Quran::Surah.find_by(permalink: params[:permalink])
               end

      respond_to do |format|
        format.html
        format.json { render json: @surah }
      end
    end
  end
end
