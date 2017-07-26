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
  enum revelation_type: [ :meccan, :medinan ]
  has_many :ayahs, -> { order('id asc') }

  # Returns the next surah if surah < surah.last.
  # If surah is last, returns first surah.
  def next
  	if id < Surah.last.id
  		self.class.find(id + 1)
  	else
  		self.class.first
  	end
  end
end
