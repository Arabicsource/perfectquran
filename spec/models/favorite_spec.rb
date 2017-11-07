# frozen_string_literal: true

# == Schema Information
#
# Table name: favorites
#
#  id         :integer          not null, primary key
#  ayah_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Favorite, type: :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to(:ayah).counter_cache true }
end
