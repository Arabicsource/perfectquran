# frozen_string_literal: true

# == Schema Information
#
# Table name: texts
#
#  id             :integer          not null, primary key
#  content        :text
#  translation_id :integer
#  ayah_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Text < ApplicationRecord
  searchkick

  default_scope { order('id asc') }

  belongs_to :translation
  belongs_to :ayah
  scope :ordered_by_quran_id, -> { joins(:quran).order('qurans.id') }

  def uthmani?
    translation_id == 1
  end
end
