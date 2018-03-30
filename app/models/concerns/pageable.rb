# frozen_string_literal: true

module Pageable
  extend ActiveSupport::Concern

  included do
    has_many :pages, -> { distinct }, through: :ayahs, class_name: 'Quran::Page'
  end

  def first_page
    pages.first
  end
end
