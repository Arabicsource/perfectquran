# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryGirl.build(:post) }
  subject { post }

  it { is_expected.to be_valid }
  it { is_expected.to respond_to :title }
  it { is_expected.to respond_to :content }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :content }
end