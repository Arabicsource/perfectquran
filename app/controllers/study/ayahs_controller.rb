# frozen_string_literal: true

module Study
  # :nodoc:
  class AyahsController < ApplicationController
    def show
      @tag = Tag.new

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
