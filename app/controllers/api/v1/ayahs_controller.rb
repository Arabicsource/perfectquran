# frozen_string_literal: true

module Api
  module V1
    # :nodoc:
    class AyahsController < Api::V1::BaseController
      def index
        render json: Ayah.all
      end

      def show
        ayah = if params[:id]
                 Ayah.find(params[:id])
               else
                 Ayah.find_by!(
                   surah_id: params[:surah_id],
                   number: params[:ayah_number]
                 )
               end
        render json: ayah
      end
    end
  end
end
