# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id             :integer          not null, primary key
#  title          :string
#  content        :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  visibility     :integer          default("draft")
#  permalink      :string
#  collection     :integer          default("post")
#  category_id    :integer
#  account_id     :integer
#  comments_count :integer          default(0)
#

require 'rails_helper'

RSpec.describe Article, type: :model do
  context 'associations' do
    it { is_expected.to belong_to :category }
    it { is_expected.to belong_to :account }
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

  describe '#category_name' do
    it 'returns the category name' do
      category = create :category, name: 'cat123'
      article = create :article, category: category

      expect(article.category_name).to eq 'cat123'
    end
  end

  describe '#permalink' do
    it 'is a parameterized version of the title' do
      article = create :article, title: 'This is my Title'
      expect(article.permalink).to eq 'this-is-my-title'
    end
  end

  context '#published_pages' do
    it 'returns published pages' do
      create :article, title: 'first', collection: :page, visibility: :published
      create :article, title: 'second', collection: :page, visibility: :draft
      create :article, title: 'third', collection: :post, visibility: :published
      create :article, title: 'forth', collection: :page, visibility: :published

      expect(Article.published_pages.map(&:title)).to eq %w[forth first]
    end
  end

  context '#published_posts' do
    it 'returns published pages' do
      create :article, title: 'first', collection: :post, visibility: :published
      create :article, title: 'second', collection: :post, visibility: :draft
      create :article, title: 'third', collection: :page, visibility: :published
      create :article, title: 'forth', collection: :post, visibility: :published

      expect(Article.published_posts.map(&:title)).to eq %w[forth first]
    end
  end
end
