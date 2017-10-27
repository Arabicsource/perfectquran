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
  subject { FactoryBot.build_stubbed(:category) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to have_many :posts }

  describe '#all_active' do
    it 'returns all unique categories with posts' do
      FactoryBot.create(
        :post, category: FactoryBot.create(:category, name: 'first')
      )
      FactoryBot.create(
        :post, category: FactoryBot.create(:category, name: 'second')
      )
      FactoryBot.create(:category, name: 'none')

      expect(Category.all_active.map(&:name)).to eq %w[first second]
    end
  end
end
