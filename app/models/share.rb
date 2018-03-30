# frozen_string_literal: true

class Share < ApplicationRecord
  belongs_to :ayah, class_name: 'Quran::Ayah'
end
