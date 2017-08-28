class AyahsController < ApplicationController
  def show
    @surah = Surah.find(params[:surah_id])
    @ayah = @surah.ayahs.find_by(number: params[:number])
  end
end