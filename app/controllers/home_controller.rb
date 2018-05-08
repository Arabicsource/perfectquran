# frozen_string_literal: true

class HomeController < ApplicationController
  def show
    @connections = Connection.all_active.sample(6)
  end
end
