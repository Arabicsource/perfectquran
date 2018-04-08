# frozen_string_literal: true

module Admin
  class MosquesController < Admin::BaseController
    def index
      @mosques = Mosque.all
    end

    def new
      @mosque = Mosque.new
    end

    def create
      @mosque = Mosque.new(mosque_params)
      flash[:success] = 'Alhamdulillah, the mosque was added'
      @mosque.save
      redirect_to admin_mosques_path
    end

    private

    def mosque_params
      params.require(:mosque)
            .permit(
              :name, :phone, :email, :street, :city_id, :zip_code, :website
            )
    end
  end
end
