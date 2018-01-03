# frozen_string_literal: true

module Accounts
  module Registrations
    # :nodoc:
    class MemoriesController < Accounts::BaseController
      def new
        @commonly_memorized_surahs = Quran::Surah.commonly_memorized
      end
    end
  end
end
