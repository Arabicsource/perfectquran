# frozen_string_literal: true

module Accounts
  module Memories
    module Surahs
      # :nodoc:
      class MemoriesController < Accounts::BaseController
        def create
          @surah = Quran::Surah.find_by(id: params[:surah_id])

          @surah.ayahs.each do |ayah|
            Memory.find_or_create_by(ayah: ayah, account: current_account)
          end

          render :create
        end

        def destroy
          @surah = Quran::Surah.find_by(id: params[:surah_id])

          Memory.where(account: current_account, ayah: @surah.ayahs).delete_all

          render :destroy
        end
      end
    end
  end
end
