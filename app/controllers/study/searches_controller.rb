# frozen_string_literal: true

module Study
  class SearchesController < ApplicationController
    def show
      @terms = params[:terms]

      return redirect_to root_url if @terms.nil? || @terms.empty?

      @results = Quran::Text.search(
        @terms, fields: [:content], highlight: true
      )
    end
  end
end
