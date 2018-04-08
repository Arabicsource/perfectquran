# frozen_string_literal: true

module Admin
  class CitiesController < Admin::BaseController
    def index
      @cities = City.all
    end

    def new
      @city = City.new
    end

    def create
      @city = City.new(city_params)
      flash[:success] = 'Alhamdulillah, the city was added'
      @city.save
      redirect_to admin_cities_path
    end

    private

    def city_params
      params.require(:city).permit(:name, :code, :state_id)
    end
  end
end
