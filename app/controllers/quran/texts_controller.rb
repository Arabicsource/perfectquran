# frozen_string_literal: true

module Quran
  # :nodoc:
  class TextsController < Quran::BaseController
    def index
      @terms = params[:terms]

      return unless @terms

      @results = Quran::Text.search(
        @terms, fields: [:content], highlight: true
      )
    end
  end
end
