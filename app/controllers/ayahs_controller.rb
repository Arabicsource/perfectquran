# frozen_string_literal: true

# :nodoc:
class AyahsController < ApplicationController
  def show
    @ayah = AyahFacade.new(params[:surah_id], params[:number], current_user)
  end
end
