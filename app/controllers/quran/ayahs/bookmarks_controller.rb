# frozen_string_literal: true

module Quran
  module Ayahs
    # :nodoc:
    class BookmarksController < Quran::BaseController
      before_action :authorize_current_account
      # respond_to :js

      def create
        @ayah = Ayah.find_by(id: params[:ayah_id])
        @bookmark = Quran::Bookmark.new(
          bookmarkable: @ayah, account: current_account
        )

        if @bookmark.save
          render :create
        else
          render json: 'unprocessible entity', status: :unprocessable_entity
        end
      end

      def destroy
        @ayah = Ayah.find_by(id: params[:ayah_id])
        @bookmark = Quran::Bookmark.find_by(
          bookmarkable: @ayah, account: current_account
        )

        if @bookmark.try :delete
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
end
