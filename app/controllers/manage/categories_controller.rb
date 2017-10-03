# frozen_string_literal: true

module Manage
  # :nodoc:
  class CategoriesController < Manage::BaseController
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
        flash[:success] = t 'manage.category.created'
        redirect_to manage_categories_path
      end
    end

    def edit
      @category = Category.find(params[:id])
    end

    def update
      @category = Category.find(params[:id])

      if @category.update_attributes(category_params)
        flash[:success] = t 'manage.category.edited'
        redirect_to manage_categories_path
      end
    end

    def destroy
      @category = Category.find(params[:id])
      @category.delete
      flash[:success] = t 'manage.category.deleted'
      redirect_to manage_categories_path
    end

    private def category_params
      params.require(:category).permit(:name)
    end
  end
end
