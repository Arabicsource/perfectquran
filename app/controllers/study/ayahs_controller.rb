# frozen_string_literal: true

module Study
  class AyahsController < ApplicationController
    def index
      respond_to do |format|
        format.json { render json: Ayah.all }
      end
    end

    def show
      @tag = Tag.new
      @ayah = load_ayah

      respond_to do |format|
        format.html
        format.json { render json: @ayah }
      end
    end

    private

    def load_ayah
      if params[:surah_id].nil?
        Ayah.find(params[:id])
      else
        Ayah.find_by(
          surah_id: params[:surah_id], number: params[:number]
        )
      end
    end
  end
end
