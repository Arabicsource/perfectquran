# frozen_string_literal: true

module Api
  module V1
    # :nodoc:
    class AyahsController < ApplicationController
      def index
        render json: Ayah.all
      end

      def show
        ayah = Ayah.find(params[:id]) ||
               Ayah.find_by!(
                 surah_id: params[:surah_id],
                 number: params[:ayah_number]
               )
        render json: ayah
      end
    end
  end
end
