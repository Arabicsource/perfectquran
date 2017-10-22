# frozen_string_literal: true

# == Schema Information
#
# Table name: flags
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  comment_id :integer
#  ip_address :string
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  approved   :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe Flag, type: :model do
  subject { FactoryGirl.build(:flag) }

  it { is_expected.to be_valid }

  it { is_expected.to respond_to :user }
  it { is_expected.to respond_to :comment }
  it { is_expected.to respond_to :ip_address }
  it { is_expected.to respond_to :content }
  it { is_expected.to respond_to :created_at }
  it { is_expected.to respond_to :updated_at }
  it { is_expected.to respond_to :approved }

  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :comment }

  it { is_expected.to validate_presence_of :ip_address }
  it { is_expected.to validate_presence_of :content }
end
