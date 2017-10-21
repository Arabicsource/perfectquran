class Quran::SurahsController < Quran::BaseController
  def index
    @surahs = Surah.all
    render layout: 'fullpage'
  end

  def show
    if params[:permalink].nil?
      @surah = Surah.find(params[:id])
    else
      @surah = Surah.find_by(permalink: params[:permalink])
    end
  end
end
