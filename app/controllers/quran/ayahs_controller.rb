# frozen_string_literal: true

module Quran
  # :nodoc:
  class AyahsController < Quran::BaseController
    def show
      @ayah = if params[:surah_id].nil?
                Ayah.find(params[:id])
              else
                Ayah.find_by(
                  surah_id: params[:surah_id], number: params[:number]
                )
              end
    end
  end
end
