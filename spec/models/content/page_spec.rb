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

RSpec.describe Content::Page, type: :model do
  subject { FactoryBot.create(:page, title: 'This is my title') }

  it { is_expected.to be_valid }
  it { is_expected.to validate_uniqueness_of(:permalink).case_insensitive }
  it { is_expected.to validate_presence_of :content }

  describe '#permalink' do
    it 'is a parameterized version of the title' do
      expect(subject.permalink).to eq 'this-is-my-title'
    end
  end
end
