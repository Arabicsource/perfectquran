# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id             :bigint(8)        not null, primary key
#  title          :string
#  content        :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  visibility     :integer          default("draft")
#  permalink      :string
#  collection     :integer          default("post")
#  category_id    :bigint(8)
#  account_id     :bigint(8)
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
    it { is_expected.to validate_uniqueness_of(:permalink).case_insensitive }
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
      Article.destroy_all
      create :article, title: 'first'
      create :article, title: 'second'
      create :article, title: 'third'

      expect(Article.all.map(&:title)).to eq %w[third second first]
    end
  end

  describe '#author_name' do
    context 'when profile has name' do
      it 'returns the account name' do
        account = create :account
        account.profile.update_attribute :name, 'name123'
        article = create :article, account: account

        expect(article.author_name).to eq 'name123'
      end
    end

    context 'when profile has no name' do
      it 'returns the account name' do
        account = create :account
        article = create :article, account: account

        expect(article.author_name).to eq 'Anonymous'
      end
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
      Article.destroy_all
      create :article, title: 'first', collection: :post, visibility: :published
      create :article, title: 'second', collection: :post, visibility: :draft
      create :article, title: 'third', collection: :page, visibility: :published
      create :article, title: 'forth', collection: :post, visibility: :published

      expect(Article.published_posts.map(&:title)).to eq %w[forth first]
    end
  end

  describe 'to_s' do
    let(:article) { create :article, title: 'title123' }

    specify { expect(article.to_s).to eq 'Article: title123' }
  end
end
