# frozen_string_literal: true

module Study
  # :nodoc:
  class SurahsController < ApplicationController
    def index
      @surahs = Surah.all

      respond_to do |format|
        format.html
        format.json { render json: @surah }
      end
    end

    def show
      @surah = if params[:permalink].nil?
                 Surah.find(params[:id])
               else
                 Surah.find_by(permalink: params[:permalink])
               end

      respond_to do |format|
        format.html
        format.json { render json: @surah }
      end
    end
  end
end
