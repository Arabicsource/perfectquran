# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'associations' do
    it { is_expected.to have_many :articles }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :description }
  end

  describe 'to_s' do
    let(:category) { create :category, name: 'category123' }

    specify { expect(category.to_s).to eq 'Category: category123' }
  end
end
