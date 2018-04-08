# frozen_string_literal: true

module Admin
  class CountriesController < Admin::BaseController
    def index
      @countries = Country.all
    end

    def new
      @country = Country.new
    end

    def create
      @country = Country.new(country_params)
      flash[:success] = 'Alhamdulillah, the country was added'
      @country.save
      redirect_to admin_countries_path
    end

    private

    def country_params
      params.require(:country).permit(:name, :code, :email)
    end
  end
end
