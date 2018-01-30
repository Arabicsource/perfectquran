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

    def create
      Quran::Ayah.all.each do |ayah|
        Memory.find_or_create_by(account: current_account, ayah: ayah)
      end

      render :create
    end

    def destroy
      Memory.where(account: current_account).delete_all

      render :destroy
    end
  end
end
