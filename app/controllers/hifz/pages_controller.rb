# frozen_string_literal: true

module Hifz
  # :nodoc:
  class PagesController < ApplicationController
    def index
      @pages = Page.all
    end

    def show
      @page = Page.find(params[:id])
    end
  end
end
