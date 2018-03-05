# frozen_string_literal: true

module Study
  class SurahsController < ApplicationController
    def index
      @surahs = Surah.all
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
