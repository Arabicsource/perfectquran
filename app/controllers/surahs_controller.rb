class SurahsController < ApplicationController
  def index
    @surahs = Surah.all
  end

  def show
  end
end
