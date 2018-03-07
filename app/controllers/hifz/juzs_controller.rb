module Hifz
  class JuzsController < ApplicationController
    def index
      @juzs = Juz.all
    end
  end
end