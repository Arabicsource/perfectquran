module Ayahable
  extend ActiveSupport::Concern

  included do
    has_many :ayahs
  end

  def current_ayah
    @current_ayah ||= first_ayah
  end

  def first_ayah
    ayahs.first
  end
end