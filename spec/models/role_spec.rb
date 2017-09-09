# frozen_string_literal: true

# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Role, type: :model do
  let(:role) { FactoryGirl.build(:role) }
  subject { role }

  it { is_expected.to be_valid }
  it { is_expected.to respond_to :name }
end
