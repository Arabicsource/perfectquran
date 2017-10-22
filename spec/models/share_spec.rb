# frozen_string_literal: true

# == Schema Information
#
# Table name: shares
#
#  id         :integer          not null, primary key
#  ayah_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Share, type: :model do
  subject { FactoryGirl.build_stubbed :share, ayah: Quran::Ayah.first }

  it { is_expected.to be_valid }
end
