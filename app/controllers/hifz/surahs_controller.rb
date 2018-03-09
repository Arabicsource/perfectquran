module Hifz
  class SurahsController < ApplicationController
    def index
      @surahs = Surah.all
    end
  end
end