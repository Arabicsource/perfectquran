# frozen_string_literal: true

module Accounts
  # :nodoc:
  class MemoriesController < Accounts::BaseController
    def show
      @memories = Memory.where(account: current_account)
      ayah_ids = @memories.map(&:ayah_id)
      @memory_count = Quran::Ayah.where(id: ayah_ids).sum(:character_length)
      @not_memorized_surahs = current_account.not_memorized_surahs
      @partially_memorized_surahs = current_account.partially_memorized_surahs
      @memorized_surahs = current_account.memorized_surahs
    end
  end
end
