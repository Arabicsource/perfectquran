# frozen_string_literal: true

class DailyAyah < ApplicationRecord
  belongs_to :ayah, class_name: 'Quran::Ayah'
end
