# frozen_string_literal: true

# == Schema Information
#
# Table name: account_translations
#
#  id             :bigint(8)        not null, primary key
#  account_id     :bigint(8)
#  translation_id :bigint(8)
#  order          :integer          default(0)
#  primary        :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe AccountTranslation, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :account }
    it { is_expected.to belong_to :translation }
  end
end
