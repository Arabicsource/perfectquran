# frozen_string_literal: true

module Quran
  class AyahsController < ApplicationController
    layout 'quran'

    def show
      @ayah = load_ayah
      @texts = load_texts
    end

    private

    def load_ayah
      if params.key? :permalink
        Ayah.find_by_reference params[:permalink], params[:number]
      else
        Ayah.find_by(
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
