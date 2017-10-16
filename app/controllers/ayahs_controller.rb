# frozen_string_literal: true

# :nodoc:
class AyahsController < ApplicationController
  def show
    @ayah = AyahFacade.new(params[:surah_id], params[:number], current_user)
    @commentable = Ayah.find_by(surah_id: params[:surah_id], number: params[:number])
    @comment = Comment.new
  end
end
