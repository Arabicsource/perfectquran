# frozen_string_literal: true

module Api
  module V1
    # :nodoc:
    class MemoriesController < Api::V1::BaseController
      skip_before_action :verify_authenticity_token
      before_action :authenticate_user!, only: :create

      def index
        ayah = Ayah.find(params[:ayah_id])
        render json: ayah.memories
      end

      def create
        ayah = Ayah.find(params[:ayah_id])
        memory = ayah.memories.build(user_id: current_user.id)
        memory.save
        render json: memory
      end

      def destroy
        memory = Memory.find(params[:id])
        memory.destroy
        render json: { message: 'Successfully Deleted' }
      end
    end
  end
end
