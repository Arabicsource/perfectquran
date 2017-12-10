# frozen_string_literal: true

module Admin
  # :nodoc:
  class MenuLinksController < Admin::BaseController
    def new
      @menu = Menu.find(params[:menu_id])
      @menu_link = MenuLink.new
    end

    def create
      @menu = Menu.find(params[:menu_id])
      @menu_link = @menu.menu_links.new(menu_link_params)

      if @menu_link.save
        flash[:success] = I18n.t(
          'admin.menu_links.create.success_notification', name: @menu_link.name
        )
        redirect_to admin_menu_path(@menu)
      else
        render :new
      end
    end

    def edit
      @menu = Menu.find(params[:menu_id])
      @menu_link = MenuLink.find(params[:id])
    end

    def update
      @menu = Menu.find(params[:menu_id])
      @menu_link = MenuLink.find(params[:id])

      if @menu_link.update_attributes(menu_link_params)
        flash[:success] = I18n.t(
          'admin.menu_links.update.success_notification', name: @menu_link.name
        )
        redirect_to admin_menu_path(@menu)
      else
        render :edit
      end
    end

    def destroy
      @menu = Menu.find(params[:menu_id])
      @menu_link = MenuLink.find(params[:id])

      @menu_link.delete
      flash[:success] = t(
        'admin.menu_links.destroy.success_notification', name: @menu_link.name
      )
      redirect_to admin_menu_path(@menu)
    end

    private

    def menu_link_params
      params.require(:menu_link).permit(:name, :path)
    end
  end
end
