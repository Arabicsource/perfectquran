# frozen_string_literal: true

# == Schema Information
#
# Table name: facebook_shares
#
#  id         :integer          not null, primary key
#  ayah_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe FacebookShare, type: :model do
  subject { build_stubbed :facebook_share }

  it { is_expected.to belong_to :ayah }
end
