# frozen_string_literal: true

# :nodoc:
class AyahsController < ApplicationController
  def show
    @surah = Surah.find(params[:surah_id])
    @ayah = @surah.ayahs.find_by(number: params[:number])

    return unless current_user

    @memory = Memory.find_or_initialize_by(
      ayah_id: @ayah.id, user_id: current_user.id
    )
    @favorite = Favorite.find_or_initialize_by(
      ayah_id: @ayah.id, user_id: current_user.id
    )
  end
end
