class Quran::SurahsController < Quran::BaseController
  def index
    @surahs = Surah.all
    render layout: 'fullpage'
  end
end
