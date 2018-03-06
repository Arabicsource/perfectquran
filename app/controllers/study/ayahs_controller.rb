# frozen_string_literal: true

module Study
  # :nodoc:
  class AyahsController < ApplicationController
    def index
      respond_to do |format|
        format.json { render json: Ayah.all }
      end
    end

    def show
      @tag = Tag.new

      @ayah = if params[:surah_id].nil?
                Ayah.find(params[:id])
              else
                Ayah.find_by(
                  surah_id: params[:surah_id], number: params[:number]
                )
              end

      respond_to do |format|
        format.html
        format.json { render json: @ayah }
      end
    end
  end
end
