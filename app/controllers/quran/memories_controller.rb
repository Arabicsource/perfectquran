# frozen_string_literal: true

module Quran
  # :nodoc:
  class MemoriesController < Quran::BaseController
    before_action :authenticate_account!

    def new
      flash[:success] = 'Thank you for joining'
      @commonly_memorized_surahs = Quran::Surah.commonly_memorized
    end
  end
end
