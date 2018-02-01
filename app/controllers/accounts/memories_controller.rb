# frozen_string_literal: true

module Accounts
  # :nodoc:
  class MemoriesController < Accounts::BaseController
    def show
      @hifz_manager = HifzManager.new(current_account)
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
