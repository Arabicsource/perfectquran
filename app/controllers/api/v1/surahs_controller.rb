class Api::V1::SurahsController < ApplicationController

  def index
    render json: Surah.all
  end

  def show
    render json: Surah.find(params[:id])
  end
end