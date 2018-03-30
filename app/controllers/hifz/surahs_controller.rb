# frozen_string_literal: true

module Hifz
  class SurahsController < ApplicationController
    def index
      @surahs = Quran::Surah.all
    end
  end
end
