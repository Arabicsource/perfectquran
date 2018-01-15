# frozen_string_literal: true

# == Schema Information
#
# Table name: quran_bookmarks
#
#  id                :integer          not null, primary key
#  bookmarkable_type :string
#  bookmarkable_id   :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'rails_helper'

RSpec.describe Quran::Bookmark, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:bookmarkable) }
  end
end
