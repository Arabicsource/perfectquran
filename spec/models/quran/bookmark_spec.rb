# frozen_string_literal: true

# == Schema Information
#
# Table name: bookmarks
#
#  id         :bigint(8)        not null, primary key
#  ayah_id    :bigint(8)
#  account_id :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Quran::Bookmark, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :ayah }
    it { is_expected.to belong_to :account }
  end

  specify 'to_s' do
    bookmark = create :bookmark

    expect(bookmark.to_s).to eq "Bookmark #{bookmark.id}"
  end
end
