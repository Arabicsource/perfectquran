class Api::V1::TextsController < ApplicationController

  # Example GET /api/v1/text/ayah/1/quran/1
  def show
    render json: Text.find_by!(ayah_id: params[:ayah_id], quran_id: params[:quran_id])
  end
end