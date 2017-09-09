# frozen_string_literal: true

# == Schema Information
#
# Table name: topics
#
#  id               :integer          not null, primary key
#  subject          :string
#  content          :text
#  discussable_type :string
#  discussable_id   :integer
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:topic) { FactoryGirl.build(:topic) }
  subject { topic }

  it { is_expected.to be_valid }
  it { is_expected.to respond_to :subject }
  it { is_expected.to respond_to :content }
  it { is_expected.to validate_presence_of :subject }
  it do
    is_expected.to validate_length_of(:subject).is_at_least(3).is_at_most(100)
  end
  it { is_expected.to validate_presence_of :content }
  it { is_expected.to validate_length_of(:content).is_at_least(3) }
end
