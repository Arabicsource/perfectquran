class Juz < ApplicationRecord
  has_many :ayahs
  has_many :pages, -> { distinct }, through: :ayahs

  def first_page
    pages.first
  end

  def description

  end

  def to_s
    "Juz #{id}"
  end
end
