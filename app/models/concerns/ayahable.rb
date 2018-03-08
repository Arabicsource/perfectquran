module Ayahable
  extend ActiveSupport::Concern

  included do
    has_many :ayahs
  end

  def current_ayah
    @current_ayah ||= first_ayah
  end

  def current_ayah=(ayah)
    @current_ayah = ayah.id.in?(ayahs.ids) ? ayah : first_ayah
  end

  def current_ayah?(ayah)
    current_ayah == ayah
  end

  def first_ayah
    ayahs.first
  end

  def previous_ayah
    previous_ayah? ? current_ayah.previous : last_ayah
  end

  def previous_ayah?
    current_ayah.id > first_ayah.id
  end

  def last_ayah
    ayahs.last
  end

  def next_ayah
    next_ayah? ? current_ayah.next : first_ayah
  end

  def next_ayah?
    current_ayah.id < last_ayah.id
  end
end
