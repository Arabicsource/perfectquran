# frozen_string_literal: true

class Account
  module Memories
    # :nodoc:
    class SurahsController < Account::BaseController
      def show
        @surah = Quran::Surah.find(params[:id])
        ayah_ids = Memory.where(
          account: current_account, ayah_id: @surah.ayah_ids
        ).map(&:ayah_id)
        @memory_count = Quran::Ayah.where(id: ayah_ids).sum(:character_length)
        @not_memorized_ayahs = current_account.not_memorized_ayahs(@surah)
        @memorized_ayahs = current_account.memorized_ayahs(@surah)
      end
    end
  end
end
