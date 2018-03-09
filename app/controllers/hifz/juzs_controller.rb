# frozen_string_literal: true

module Hifz
  # :nodoc:
  class JuzsController < ApplicationController
    def index
      @juzs = Juz.all
    end
  end
end
