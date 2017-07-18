class Api::V1::AyahsController < ApplicationController

  def index
    render json: Ayah.all
  end

  def show
    if params[:id]
      ayah = Ayah.find(params[:id])
    else
      ayah = Ayah.find_by!(surah_id: params[:surah_id], number: params[:ayah_number])
    end
    render json: ayah
  end
end