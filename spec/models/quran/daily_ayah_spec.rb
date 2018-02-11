# == Schema Information
#
# Table name: quran_daily_ayahs
#
#  id            :integer          not null, primary key
#  quran_ayah_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Quran::DailyAyah, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
