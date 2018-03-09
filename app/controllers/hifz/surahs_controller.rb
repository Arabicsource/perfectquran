# frozen_string_literal: true

module Hifz
  # :nodoc:
  class SurahsController < ApplicationController
    def index
      @surahs = Surah.all
    end
  end
end
