# frozen_string_literal: true

class MosquesController < ApplicationController
  def show
    @mosque = Mosque.find params[:id]
  end
end
