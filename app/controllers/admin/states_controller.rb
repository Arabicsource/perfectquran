# frozen_string_literal: true

module Admin
  class StatesController < Admin::BaseController
    def index
      @states = State.all
    end

    def new
      @state = State.new
    end

    def create
      @state = State.new(state_params)
      flash[:success] = 'Alhamdulillah, the state was added'
      @state.save
      redirect_to admin_states_path
    end

    private

    def state_params
      params.require(:state).permit(:name, :code, :country_id)
    end
  end
end
