# frozen_string_literal: true

module Admin
  class BookmarksController < Admin::BaseController
    def index
      @resources = Quran::Bookmark.all
    end

    def show
      @resource = Quran::Bookmark.find(params[:id])
    end

    def destroy
      @resource = Quran::Bookmark.find(params[:id])

      if @resource.delete
        flash[:success] = 'Alhamdulillah, the bookmark was deleted'
      end

      redirect_to admin_bookmarks_path
    end
  end
end
