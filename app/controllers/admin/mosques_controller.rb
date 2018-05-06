# frozen_string_literal: true

module Admin
  class MosquesController < Admin::BaseController
    def index
      @resources = Mosque.all
    end

    def show
      @resource = Mosque.find(params[:id])
    end

    def new
      @resource = Mosque.new
    end

    def edit
      @resource = Mosque.find(params[:id])
    end

    def create
      @resource = Mosque.new(mosque_params)

      if @resource.save
        flash[:success] = 'Alhamdulillah, the mosque was added'
        redirect_to admin_mosques_path
      else
        respond_to do |format|
          format.html { render :new, status: 422 }
          format.js
        end
      end
    end

    def update
      @resource = Mosque.find(params[:id])

      if @resource.update_attributes(mosque_params)
        flash[:success] = 'Alhamdulillah, the mosque was updated'
        redirect_to admin_mosques_path
      else
        respond_to do |format|
          format.html { render :edit, status: 422 }
          format.js
        end
      end
    end

    def destroy
      @resource = Mosque.find(params[:id])

      return unless @resource.delete

      flash[:success] = 'Alhamdulillah, the mosque was deleted'
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
