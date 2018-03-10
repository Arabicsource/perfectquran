# frozen_string_literal: true

module Study
  class TextsController < ApplicationController
    def show
      text = Text.find_by!(
        ayah_id: params[:ayah_id], translation_id: params[:translation_id]
      )

      respond_to do |format|
        format.json { render json: text }
      end
    end
  end
end
