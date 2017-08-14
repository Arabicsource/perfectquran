class Api::V1::FavoritesController < ApplicationController
    def create
        ayah = Ayah.find(params[:ayah_id])
        favorite = ayah.favorites.build(user_id: current_user.id)
        favorite.save
        render json: favorite
    end    

    def destroy
        favorite = Favorite.find(params[:id])
        favorite.delete
        render json: { message: "Successfully Deleted" }
    end
end