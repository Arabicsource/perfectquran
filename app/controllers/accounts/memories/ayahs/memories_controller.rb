# frozen_string_literal: true

module Accounts
  module Memories
    module Ayahs
      # :nodoc:
      class MemoriesController < Accounts::BaseController
        before_action :load_resources

        def create
          @memory = Memory.new(ayah: @ayah, account: current_account)

          if @memory.save
            @memory_count = memory_count
            render :create
          else
            render json: 'unprocessible entity', status: :unprocessable_entity
          end
        end

        def destroy
          @memory = Memory.find_by(ayah: @ayah, account: current_account)

          @memory.try(:delete)
          @memory_count = memory_count
          render :destroy
        end

        private

        def memory_count
          ayah_ids = Memory.where(
            account: current_account, ayah_id: @surah.ayah_ids
          ).map(&:ayah_id)

          @memory_count = Quran::Ayah.where(id: ayah_ids)
                                     .sum(:character_length)
        end

        def load_resources
          @ayah = Quran::Ayah.find_by(id: params[:ayah_id])
          @surah = @ayah.surah
        end
      end
    end
  end
end
