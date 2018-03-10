# frozen_string_literal: true

module Hifz
  class AyahsController < ApplicationController
    def show
      @page = Page.find(params[:page_id])
      @page.current_ayah = Ayah.find(params[:id])

      render 'hifz/pages/show'
    end
  end
end
