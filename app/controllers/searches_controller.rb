# frozen_string_literal: true

# :nodoc:
class SearchesController < ApplicationController
  def show
    @texts = Text.search params[:id], page: params[:page], per_page: 20
  end

  def create
    redirect_to search_path(params[:terms])
  end
end
