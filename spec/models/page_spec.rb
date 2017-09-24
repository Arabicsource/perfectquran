# frozen_string_literal: true

# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  permalink  :string
#

require 'rails_helper'

RSpec.describe Page, type: :model do
  let(:page) { FactoryGirl.build(:page) }
  subject { page }

  it { is_expected.to be_valid }
  it { is_expected.to respond_to :title }
  it { is_expected.to respond_to :permalink }
  it { is_expected.to respond_to :content }
  it { is_expected.to validate_uniqueness_of(:permalink).case_insensitive }
  it { is_expected.to validate_presence_of :content }

  describe '#permalink' do
    it 'is a parameterized version of the title' do
      subject.title = 'This Is My Title'
      subject.save
      expect(subject.permalink).to eq 'this-is-my-title'
    end
  end
end
