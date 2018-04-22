# frozen_string_literal: true

# == Schema Information
#
# Table name: daily_ayahs
#
#  id         :bigint(8)        not null, primary key
#  ayah_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DailyAyah < ApplicationRecord
  belongs_to :ayah, class_name: 'Quran::Ayah'
end
