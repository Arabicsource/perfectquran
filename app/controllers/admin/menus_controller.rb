# frozen_string_literal: true

module Admin
  # :nodoc:
  class MenusController < Admin::BaseController
    def index
      @menus = Menu.all
    end

    def show
      @menu = Menu.find(params[:id])
    end

    def new
      @menu = Menu.new
    end

    def create
      @menu = Menu.new(menu_params)

      if @menu.save
        flash[:success] = I18n.t(
          'admin.menus.create.success_notification', name: @menu.name
        )
        redirect_to admin_menus_path
      else
        render :new
      end
    end

    def edit
      @menu = Menu.find(params[:id])
    end

    def update
      @menu = Menu.find(params[:id])

      if @menu.update_attributes(menu_params)
        flash[:success] = I18n.t(
          'admin.menus.update.success_notification', name: @menu.name
        )
        redirect_to admin_menus_path
      else
        render :edit
      end
    end

    def destroy
      @menu = Menu.find(params[:id])
      @menu.delete
      flash[:success] = t(
        'admin.menus.destroy.success_notification', name: @menu.name
      )
      redirect_to admin_menus_path
    end

    private

    def menu_params
      params.require(:menu).permit(:name, :description)
    end
  end
end
