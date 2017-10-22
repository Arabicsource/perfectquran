# frozen_string_literal: true

# == Schema Information
#
# Table name: surahs
#
#  id                  :integer          not null, primary key
#  number_of_ayahs     :integer
#  order_of_revelation :integer
#  revelation_type     :integer
#  permalink           :string
#  transliterated_name :string
#  arabic_name         :string
#  english_name        :string
#  character_length    :integer
#  percent_of_total    :float
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class Surah < ApplicationRecord
  enum revelation_type: %i[meccan medinan]
  has_many :ayahs
  has_many :ayahs_and_included_texts,
           -> { includes(:texts_and_included_translations) },
           class_name: 'Ayah'

  # Returns the next surah if surah < surah.last.
  # If surah is last, returns first surah.
  def next
    if id < Surah.last.id
      self.class.find(id + 1)
    else
      self.class.first
    end
  end

  # Returns the previous surah if surah is > surah.first
  # If surah is first, returns last surah.
  def previous
    if id > Surah.first.id
      self.class.find(id - 1)
    else
      self.class.last
    end
  end
end
