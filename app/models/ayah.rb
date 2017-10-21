# frozen_string_literal: true

# == Schema Information
#
# Table name: ayahs
#
#  id               :integer          not null, primary key
#  number           :integer
#  character_length :integer
#  percent_of_total :float
#  percent_of_surah :float
#  surah_id         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  favorites_count  :integer          default(0)
#  memories_count   :integer          default(0)
#
class Ayah < ApplicationRecord
  include Commentable

  default_scope { order('id asc') }

  belongs_to :surah
  has_many :texts
  has_many :favorites
  has_many :memories
  has_many :texts_and_included_quran, -> { includes(:quran) }, class_name: 'Text'

  def redirect_path
    "/#{surah.id}/#{number}"
  end

  def previous?
    number > 1
  end

  def previous
    self.class.find(id - 1)
  end

  def next?
    number < surah.number_of_ayahs
  end

  def next
    self.class.find(id + 1)
  end
end
