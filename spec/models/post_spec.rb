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
  subject { FactoryGirl.build(:post) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_uniqueness_of(:permalink).case_insensitive }
  it { is_expected.to validate_presence_of :content }
  it { is_expected.to belong_to :category }
  it { is_expected.to have_many :comments }

  it_behaves_like 'commentable'

  describe '#redirect_path' do
    specify { expect(subject.redirect_path).to eq "/blog/posts/#{subject.permalink}" }
  end

  describe '#author_name' do
    it 'is the name of the user who authored the post' do
      subject.user = FactoryGirl.build_stubbed :user, name: 'abc123'
      expect(subject.author_name).to eq 'abc123'
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
