class Juz < ApplicationRecord
  has_many :ayahs
  has_many :pages, -> { distinct }, through: :ayahs

  has_one :juz_memory

  def first_page
    pages.first
  end

  def description

  end

  def to_s
    "Juz #{id}"
  end

  def memorized?
    character_length == juz_memory.character_length
  end

  def memorize
    ayahs.each do |ayah| 
      unless ayah.memorize
        return false
      end
    end
  end

  private

  def juz_memory
    if Current.account.guest?
      JuzMemory.new
    else
      JuzMemory.find_or_initialize_by(account: Current.account, juz: self)
    end
  end
end
