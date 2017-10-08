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
