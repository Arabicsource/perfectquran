# frozen_string_literal: true

module Api
  module V1
    # :nodoc:
    class SurahsController < Api::V1::BaseController
      def index
        render json: Quran::Surah.all
      end

      def show
        render json: Quran::Surah.find(params[:id])
      end
    end
  end
end
