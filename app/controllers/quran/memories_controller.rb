# frozen_string_literal: true

module Quran
  # :nodoc:
  class MemoriesController < Quran::BaseController
    before_action :authorize_current_account
    respond_to :js

    def create
      @ayah = Ayah.find_by(id: params[:ayah_id])
      @memory = Memory.new(ayah: @ayah, account: current_account)

      if @memory.save
        render :create
      else
        render json: 'unprocessible entity', status: :unprocessable_entity
      end
    end

    def destroy
      @ayah = Ayah.find_by(id: params[:ayah_id])
      @memory = Memory.find_by(ayah: @ayah, account: current_account)

      if @memory.try(:delete)
        render :destroy
      else
        render json: 'unprocessible entity', status: :unprocessable_entity
      end
    end

    private

    def authorize_current_account
      render json: 'not authorized', status: 401 unless current_account
    end
  end
end
