# frozen_string_literal: true

module Quran
  class BookmarksController < ApplicationController
    before_action :authenticate_account!

    def create
      @ayah = Quran::Ayah.find_by(id: params[:ayah_id])

      if @ayah.present? && @ayah.bookmarks.create(account: current_account)
        respond_to do |format|
          format.html { redirect_to quran_permalink_path(@ayah.surah) }
          format.js
        end
      else
        render plain: 'Error', status: 422
      end
    end

    # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    def destroy
      @ayah = Quran::Ayah.find_by(id: params[:ayah_id])

      if @ayah.present? &&
         @ayah.bookmarks.any? &&
         @ayah.bookmarks.find_by(account: current_account).delete
        respond_to do |format|
          format.html { redirect_to quran_permalink_path(@ayah.surah) }
          format.js
        end
      else
        render plain: 'Error', status: 422
      end
    end
    # rubocop:enable Metrics/MethodLength, Metrics/AbcSize
  end
end
