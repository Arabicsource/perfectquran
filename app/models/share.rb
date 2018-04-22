# frozen_string_literal: true

# == Schema Information
#
# Table name: shares
#
#  id         :bigint(8)        not null, primary key
#  ayah_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Share < ApplicationRecord
  belongs_to :ayah, class_name: 'Quran::Ayah'
end
