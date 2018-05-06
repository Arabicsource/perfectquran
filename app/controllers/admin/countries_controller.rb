# frozen_string_literal: true

module Admin
  class CountriesController < Admin::BaseController
    def index
      @resources = Country.all
    end

    def show
      @resource = Country.find(params[:id])
    end

    def new
      @resource = Country.new
    end

    def edit
      @resource = Country.find(params[:id])
    end

    def create
      @resource = Country.new(country_params)

      if @resource.save
        flash[:success] = 'Alhamdulillah, the country was added'
        redirect_to admin_countries_path
      else
        respond_to do |format|
          format.html { render :new, status: 422 }
          format.js
        end
      end
    end

    def update
      @resource = Country.find(params[:id])

      if @resource.update_attributes(country_params)
        flash[:success] = 'Alhamdulillah, the country was updated'
        redirect_to admin_countries_path
      else
        respond_to do |format|
          format.html { render :edit, status: 422 }
          format.js
        end
      end
    end

    def destroy
      @resource = Country.find(params[:id])

      if can_be_deleted? && @resource.delete
        flash[:success] = 'Alhamdulillah, the country was deleted'
        redirect_to admin_countries_path
      else
        flash.now[:danger] = 'The country was not deleted'
        render :show, status: 422
      end
    end

    private

    def can_be_deleted?
      @resource.states.empty?
    end

    def country_params
      params.require(:country).permit(:name, :code, :email)
    end
  end
end
