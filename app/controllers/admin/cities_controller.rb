# frozen_string_literal: true

module Admin
  class CitiesController < Admin::BaseController
    def index
      @resources = City.all
    end

    def show
      @resource = City.find(params[:id])
    end

    def new
      @resource = City.new
    end

    def edit
      @resource = City.find(params[:id])
    end

    def create
      @resource = City.new(city_params)

      if @resource.save
        flash[:success] = 'Alhamdulillah, the city was added'
        redirect_to admin_cities_path
      else
        respond_to do |format|
          format.html { render :new, status: 422 }
          format.js
        end
      end
    end

    def update
      @resource = City.find(params[:id])

      if @resource.update_attributes(city_params)
        flash[:success] = 'Alhamdulillah, the city was updated'
        redirect_to admin_cities_path
      else
        respond_to do |format|
          format.html { render :edit, status: 422 }
          format.js
        end
      end
    end

    def destroy
      @resource = City.find(params[:id])

      if can_be_deleted? && @resource.delete
        flash[:success] = 'Alhamdulillah, the city was deleted'
        redirect_to admin_cities_path
      else
        flash.now[:danger] = 'The city was not deleted'
        render :show, status: 422
      end
    end

    private

    def can_be_deleted?
      @resource.mosques.empty?
    end

    def city_params
      params.require(:city).permit(:name, :code, :state_id)
    end
  end
end
