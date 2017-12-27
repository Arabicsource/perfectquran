# frozen_string_literal: true

# == Schema Information
#
# Table name: memories
#
#  id         :integer          not null, primary key
#  account_id :integer
#  ayah_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Memory, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:ayah).class_name('Quran::Ayah') }
    it { is_expected.to belong_to :account }
  end
end