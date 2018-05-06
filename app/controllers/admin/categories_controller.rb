# frozen_string_literal: true

module Admin
  class CategoriesController < Admin::BaseController
    def index
      @resources = Category.all
    end

    def show
      @resource = Category.find(params[:id])
    end

    def new
      @resource = Category.new
    end

    def edit
      @resource = Category.find(params[:id])
    end

    def create
      @resource = Category.new(category_params)

      if @resource.save
        flash[:success] = 'Alhamdulillah, the category was added'
        redirect_to admin_categories_path
      else
        respond_to do |format|
          format.html { render :new, status: 422 }
          format.js
        end
      end
    end

    def update
      @resource = Category.find(params[:id])

      if @resource.update_attributes(category_params)
        flash[:success] = 'Alhamdulillah, the category was updated'
        redirect_to admin_categories_path
      else
        respond_to do |format|
          format.html { render :edit, status: 422 }
          format.js
        end
      end
    end

    def destroy
      @resource = Category.find(params[:id])

      if can_be_deleted? && @resource.delete
        flash[:success] = 'Alhamdulillah, the category was deleted'
        redirect_to admin_categories_path
      else
        flash.now[:danger] = 'The category was not deleted'
        render :show, status: 422
      end
    end

    private

    def can_be_deleted?
      @resource.articles.empty?
    end

    def category_params
      params.require(:category).permit(:name, :description)
    end
  end
end
