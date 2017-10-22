# frozen_string_literal: true

module Api
  module V1
    # :nodoc:
    class AyahsController < ApplicationController
      def index
        render json: Quran::Ayah.all
      end

      def show
        ayah = if params[:id]
                 Quran::Ayah.find(params[:id])
               else
                 Quran::Ayah.find_by!(
                   surah_id: params[:surah_id],
                   number: params[:ayah_number]
                 )
               end
        render json: ayah
      end
    end
  end
end
