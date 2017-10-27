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
  let(:flagged_comment) { FactoryBot.build(:comment, :with_flag) }
  let(:approved_comment) { FactoryBot.build(:comment, :with_approval) }

  before { @comment = FactoryBot.build(:comment) }
  subject { @comment }

  it { is_expected.to be_valid }
  it { is_expected.to respond_to(:content) }
  it { is_expected.to validate_presence_of :content }

  it { is_expected.to have_one :flag }

  describe '#flagged?' do
    it 'is true when it is flagged' do
      expect(flagged_comment.flagged?).to be_truthy
    end

    it 'is false when it is not flagged' do
      expect(@comment.flagged?).to be_falsey
    end
  end

  describe '#approved?' do
    it 'is false when it is not flagged' do
      expect(@comment.approved?).to be_falsey
    end

    it 'is false when it is flagged and not approved' do
      expect(flagged_comment.approved?).to be_falsey
    end

    it 'is true when it is flagged and approved' do
      expect(approved_comment.approved?).to be_truthy
    end
  end

  describe '#visible?' do
    it 'is true when it not flagged' do
      expect(@comment.visible?).to be_truthy
    end

    it 'is true when it is flagged and approved' do
      expect(approved_comment.visible?).to be_truthy
    end

    it 'is false when it is flagged and not approved' do
      flagged_comment = FactoryBot.create(:comment, :with_flag)
      expect(flagged_comment.visible?).to be_falsey
    end
  end
end
