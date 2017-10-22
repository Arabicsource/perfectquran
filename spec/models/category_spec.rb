# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  permalink  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Category, type: :model do
  before { @category = FactoryGirl.build(:category) }
  subject { @category }

  it { is_expected.to be_valid }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:permalink) }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to have_many :posts }

  describe '#all_active' do
    it 'returns all unique categories with posts' do
      FactoryGirl.create(:category, :with_posts, name: 'first')
      FactoryGirl.create(:category, :with_posts, name: 'second')
      FactoryGirl.create(:category, name: 'none')

      expect(Category.all_active.map(&:name)).to eq %w[first second]
    end
  end
end
