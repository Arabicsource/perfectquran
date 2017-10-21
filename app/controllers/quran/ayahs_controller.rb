class Quran::AyahsController < Quran::BaseController
  def show
    if params[:surah_id].nil?
      @ayah = Ayah.find(params[:id])
    else
      @ayah = Ayah.find_by(surah_id: params[:surah_id], number: params[:number])
    end
    @comment = Comment.new
  end
end
