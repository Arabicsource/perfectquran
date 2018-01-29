# frozen_string_literal: true

module Accounts
  # :nodoc:
  class MemoriesController < Accounts::BaseController
    def show
      @memories = Memory.where(account: current_account)
      ayah_ids = @memories.map(&:ayah_id)
      @memory_count = Quran::Ayah.where(id: ayah_ids).sum(:character_length)
    end
  end
end
