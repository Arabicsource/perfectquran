# frozen_string_literal: true

module Admin
  class CategoriesController < Admin::BaseController
    def index
      @categories = Category.all
    end

    def show
      @category = Category.find(params[:id])
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)

      if @category.save
        flash[:success] = I18n.t(
          'admin.categories.create.success_notification', name: @category.name
        )
        redirect_to admin_categories_path
      else
        render :new
      end
    end

    def edit
      @category = Category.find(params[:id])
    end

    def update
      @category = Category.find(params[:id])

      if @category.update_attributes(category_params)
        flash[:success] = I18n.t(
          'admin.categories.update.success_notification', name: @category.name
        )
        redirect_to admin_categories_path
      else
        render :edit
      end
    end

    def destroy
      @category = Category.find(params[:id])
      @category.delete
      flash[:success] = t(
        'admin.categories.destroy.success_notification', name: @category.name
      )
      redirect_to admin_categories_path
    end

    private

    def category_params
      params.require(:category).permit(:name, :description)
    end
  end
end
