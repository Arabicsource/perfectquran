# frozen_string_literal: true

# == Schema Information
#
# Table name: texts
#
#  id         :integer          not null, primary key
#  content    :text
#  quran_id   :integer
#  ayah_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Text < ApplicationRecord
  belongs_to :quran
  belongs_to :ayah
  scope :ordered_by_quran_id, -> { joins(:quran).order('qurans.id') }
end
