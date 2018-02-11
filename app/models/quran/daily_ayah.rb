# == Schema Information
#
# Table name: quran_daily_ayahs
#
#  id            :integer          not null, primary key
#  quran_ayah_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Quran::DailyAyah < ApplicationRecord
  belongs_to :quran_ayah, class_name: 'Quran::Ayah'
end
