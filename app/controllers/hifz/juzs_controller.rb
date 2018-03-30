# frozen_string_literal: true

module Hifz
  class JuzsController < ApplicationController
    def index
      @juzs = Quran::Juz.all
    end
  end
end
