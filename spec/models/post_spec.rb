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
  subject do
    author = FactoryBot.create(:member, name: 'Author Name')
    FactoryBot.create(:post, title: 'This is my title', user: author)
  end

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_uniqueness_of(:permalink).case_insensitive }
  it { is_expected.to validate_presence_of :content }
  it { is_expected.to belong_to :category }
  it { is_expected.to have_many :comments }

  it_behaves_like 'commentable'

  describe '#author_name' do
    it 'is the name of the user who authored the post' do
      expect(subject.author_name).to eq 'Author Name'
    end
  end

  describe '#permalink' do
    it 'is a parameterized version of the title' do
      expect(subject.permalink).to eq 'this-is-my-title'
    end
  end
end
