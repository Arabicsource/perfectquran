# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string
#  content     :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  permalink   :string
#

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryGirl.build(:post) }
  subject { post }

  it { is_expected.to be_valid }
  it { is_expected.to respond_to :title }
  it { is_expected.to respond_to :permalink }
  it { is_expected.to respond_to :content }
  it { is_expected.to respond_to :comments }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_uniqueness_of(:permalink).case_insensitive }
  it { is_expected.to validate_presence_of :content }
  it { is_expected.to belong_to :category }
  it { is_expected.to have_many :comments }

  describe '#visible_comments?' do
    it 'is false when no comments exisit' do
      expect(post.visible_comments?).to be_falsey
    end

    it 'is false when all comments have been flagged' do
      post_with_flagged_comments = FactoryGirl.create(:post, :with_flagged_comments)
      expect(post_with_flagged_comments.visible_comments?).to be_falsey
    end

    it 'is true when no comments have been flagged' do
      post_with_comments = FactoryGirl.create(:post, :with_comments)
      expect(post_with_comments.visible_comments?).to be_truthy
    end

    it 'is true when there is a mixture of flagged and unflagged comments' do
      post_with_mixed_commments = FactoryGirl.create(:post, :with_mixed_comments)
      expect(post_with_mixed_commments.visible_comments?).to be_truthy
    end
  end

  describe '#author_name' do
    it 'is the name of the user who authored the post' do
      subject.save
      expect(subject.author_name).to eq subject.user.name
    end
  end

  describe '#permalink' do
    it 'is a parameterized version of the title' do
      subject.title = 'This Is My Title'
      subject.save
      expect(subject.permalink).to eq 'this-is-my-title'
    end
  end
end
