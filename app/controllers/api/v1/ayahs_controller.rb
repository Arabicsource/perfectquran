class Api::V1::AyahsController < ApplicationController

  def index
    render json: Ayah.all
  end

  def show
    render json: Ayah.find(params[:id])
  end
end