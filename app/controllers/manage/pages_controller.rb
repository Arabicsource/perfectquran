# frozen_string_literal: true

module Manage
  # :nodoc:
  class PagesController < Manage::BaseController
    def index
      @pages = Page.all
    end

    def show
      @page = Page.find(params[:id])
    end

    def new
      @page = Page.new
    end

    def create
      @page = Page.new(page_params)
      @page.user = current_user

      if @page.save
        flash[:success] = t 'manage.page.created'
        redirect_to manage_pages_path
      else
        render :new
      end
    end

    def edit
      @page = Page.find(params[:id])
    end

    def update
      @page = Page.find(params[:id])

      if @page.update_attributes(page_params)
        flash[:success] = t 'manage.page.edited'
        redirect_to manage_pages_path
      else
        render :edit
      end
    end

    private def page_params
      params.require(:page).permit(:title, :content)
    end
  end
end
