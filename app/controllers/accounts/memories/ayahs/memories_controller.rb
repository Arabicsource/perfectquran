# frozen_string_literal: true

module Accounts
  module Memories
    module Ayahs
      # :nodoc:
      class MemoriesController < Accounts::BaseController
        def create
          @ayah = Quran::Ayah.find_by(id: params[:ayah_id])
          @surah = @ayah.surah
          @memory = Memory.new(ayah: @ayah, account: current_account)

          if @memory.save
            ayah_ids = Memory.where(
              account: current_account, ayah_id: @surah.ayah_ids
            ).map(&:ayah_id)
            @memory_count = Quran::Ayah.where(id: ayah_ids)
                                       .sum(:character_length)
            render :create
          else
            render json: 'unprocessible entity', status: :unprocessable_entity
          end
        end

        def destroy
          @ayah = Quran::Ayah.find_by(id: params[:ayah_id])
          @surah = @ayah.surah
          @memory = Memory.find_by(ayah: @ayah, account: current_account)

          @memory.try(:delete)
          ayah_ids = Memory.where(
            account: current_account, ayah_id: @surah.ayah_ids
          ).map(&:ayah_id)
          @memory_count = Quran::Ayah.where(id: ayah_ids)
                                      .sum(:character_length)
          render :destroy
        end
      end
    end
  end
end
