# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :text
#  user_id          :integer
#  commentable_type :string
#  commentable_id   :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe Comment, type: :model do
  before { @comment = FactoryGirl.build(:comment) }
  subject { @comment }

  it { is_expected.to be_valid }
  it { is_expected.to respond_to(:content) }
  it { is_expected.to validate_presence_of :content }

  it { is_expected.to have_one :flag }

  describe '#visible?' do
    it 'is true when it not flagged' do
      expect(@comment.visible?).to be_truthy
    end

    it 'is false when it is flagged' do
      flagged_comment = FactoryGirl.create(:comment, :with_flag)
      expect(flagged_comment.visible?).to be_falsey
    end
  end
end
