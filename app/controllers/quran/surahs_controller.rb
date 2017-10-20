class Quran::SurahsController < Quran::BaseController
  def index
    @surahs = Surah.all
    render layout: 'fullpage'
  end

  def show
    @surah = Surah.find(params[:id])
  end
end
