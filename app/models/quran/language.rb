# frozen_string_literal: true

# == Schema Information
#
# Table name: quran_languages
#
#  id        :integer          not null, primary key
#  name      :string
#  direction :string
#

module Quran
  # :nodoc:
  class Language < ApplicationRecord
  end
end
