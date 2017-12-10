# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id          :integer          not null, primary key
#  title       :string
#  content     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  visibility  :integer          default("draft")
#  permalink   :string
#  collection  :integer          default("post")
#  category_id :integer
#  user_id     :integer
#

require 'rails_helper'

RSpec.describe Article, type: :model do
  context 'associations' do
    it { is_expected.to belong_to :category }
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many :comments }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :content }
    it { is_expected.to validate_presence_of :permalink }
    it { is_expected.to validate_uniqueness_of :permalink }
  end

  context 'enums' do
    it do
      is_expected.to(
        define_enum_for(:visibility).with(%i[draft published trash])
      )
    end

    it do
      is_expected.to(
        define_enum_for(:collection).with(%i[post page])
      )
    end
  end

  context 'default scope' do
    it 'returns records in desc order' do
      create :article, title: 'first'
      create :article, title: 'second'
      create :article, title: 'third'

      expect(Article.all.map(&:title)).to eq %w[third second first]
    end
  end

  describe '#permalink' do
    it 'is a parameterized version of the title' do
      article = create :article, title: 'This is my Title'
      expect(article.permalink).to eq 'this-is-my-title'
    end
  end
end
