# frozen_string_literal: true

class HomeController < ApplicationController
  def show
    @connections = Connection.all_active.limit(3)
  end
end
