# frozen_string_literal: true

class Account
  # :nodoc:
  class MemoriesController < Account::BaseController
    def show
      @hifz_manager = HifzManager.new(current_account)
    end

    def create
      Ayah.all.each do |ayah|
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
