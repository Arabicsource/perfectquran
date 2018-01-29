# frozen_string_literal: true

module Accounts
  module Memories
    # :nodoc:
    class SurahsController < Accounts::BaseController
      def show
        @surah = Quran::Surah.find(params[:id])
        ayah_ids = Memory.where(
          account: current_account, ayah_id: @surah.ayah_ids
        ).map(&:ayah_id)
        @memory_count = Quran::Ayah.where(id: ayah_ids).sum(:character_length)
      end
    end
  end
end
