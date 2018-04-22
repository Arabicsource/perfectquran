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

require 'rails_helper'

RSpec.describe Share, type: :model do
  it { is_expected.to belong_to :ayah }
end
