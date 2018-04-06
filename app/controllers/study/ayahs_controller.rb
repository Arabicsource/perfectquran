# frozen_string_literal: true

module Study
  class AyahsController < ApplicationController
    def show
      @ayah = load_ayah
      @texts = load_texts
    end

    private

    def load_ayah
      if params[:surah_id].nil?
        Quran::Ayah.find(params[:id])
      else
        Quran::Ayah.find_by(
          surah_id: params[:surah_id], number: params[:number]
        )
      end
    end

    def load_texts
      if params[:translation_id]
        @ayah.texts.where(translation: [1, params[:translation_id]]).order(:id)
      elsif Current.account.translations.any?
        @ayah.account_texts
      else
        @ayah.texts.where(translation: [1, 2, 3]).order(:id)
      end
    end
  end
end
