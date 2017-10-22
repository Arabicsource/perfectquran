# frozen_string_literal: true

module Api
  module V1
    # :nodoc:
    class FavoritesController < ApplicationController
      skip_before_action :verify_authenticity_token

      def create
        ayah = Quran::Ayah.find(params[:ayah_id])
        favorite = ayah.favorites.build(user_id: current_user.id)
        favorite.save
        render json: favorite
      end

      def destroy
        favorite = Favorite.find(params[:id])
        favorite.destroy
        render json: { message: 'Successfully Deleted' }
      end
    end
  end
end
