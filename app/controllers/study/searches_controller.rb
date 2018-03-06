# frozen_string_literal: true

module Study
  # :nodoc:
  class SearchesController < ApplicationController
    def show
      @terms = params[:terms]

      return redirect_to root_url if @terms.nil? || @terms.empty?

      @results = Text.search(
        @terms, fields: [:content], highlight: true
      )
    end
  end
end
