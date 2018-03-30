# frozen_string_literal: true

module Hifz
  class PagesController < ApplicationController
    def index
      @pages = Quran::Page.all
    end

    def show
      @page = Quran::Page.find(params[:id])
    end
  end
end
