class Api::V1::MemoriesController < ApplicationController

    def create
        ayah = Ayah.find(params[:ayah_id])
        memory = ayah.memories.build(user_id: current_user.id)
        memory.save
        render json: memory
    end

    def destroy
        memory= Memory.find(params[:id])
        memory.destroy
        render json: { message: "Successfully Deleted" }
    end
end