# frozen_string_literal: true

module Quran
  module Surahs
    # :nodoc:
    class MemoriesController < Quran::BaseController
      before_action :authorize_current_account

      def create
        @surah = Surah.find_by(id: params[:surah_id])

        if @surah
          @surah.ayahs.each do |ayah|
            Memory.find_or_create_by(ayah: ayah, account: current_account)
          end

          render :create
        else
          render json: 'unprocessible entity', status: :unprocessable_entity
        end
      end

      def destroy
        @surah = Surah.find_by(id: params[:surah_id])

        if @surah
          Memory.where(account: current_account, ayah: @surah.ayahs).delete_all
          render :destroy
        else
          render json: 'unprocessible entity', status: :unprocessable_entity
        end
      end

      private

      def authorize_current_account
        render json: 'not authorized', status: 401 unless current_account
      end
    end
  end
end
