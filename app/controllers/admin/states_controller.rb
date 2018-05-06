# frozen_string_literal: true

module Admin
  class StatesController < Admin::BaseController
    def index
      @resources = State.all
    end

    def show
      @resource = State.find(params[:id])
    end

    def new
      @resource = State.new
    end

    def edit
      @resource = State.find(params[:id])
    end

    def create
      @resource = State.new(state_params)

      if @resource.save
        flash[:success] = 'Alhamdulillah, the state was added'
        redirect_to admin_states_path
      else
        respond_to do |format|
          format.html { render :new, status: 422 }
          format.js
        end
      end
    end

    def update
      @resource = State.find(params[:id])

      if @resource.update_attributes(state_params)
        flash[:success] = 'Alhamdulillah, the state was updated'
        redirect_to admin_states_path
      else
        respond_to do |format|
          format.html { render :edit, status: 422 }
          format.js
        end
      end
    end

    def destroy
      @resource = State.find(params[:id])

      if can_be_deleted? && @resource.delete
        flash[:success] = 'Alhamdulillah, the state was deleted'
        redirect_to admin_states_path
      else
        flash.now[:danger] = 'The state was not deleted'
        render :show, status: 422
      end
    end

    private

    def can_be_deleted?
      @resource.cities.empty?
    end

    def state_params
      params.require(:state).permit(:name, :code, :country_id)
    end
  end
end
