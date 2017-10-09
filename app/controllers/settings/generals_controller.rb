# frozen_string_literal: true

module Settings
  # :nodoc:
  class GeneralsController < Settings::BaseController
    def edit
      authenticate_user!
    end
  end
end
