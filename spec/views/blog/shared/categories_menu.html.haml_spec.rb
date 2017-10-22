# frozen_string_literal: true

require 'rails_helper'

describe 'blog/shared/_categories_menu' do
  context 'when category has posts' do
    it 'renders a category link once' do
      category = FactoryGirl.create(:category, :with_posts)

      render

      expect(rendered).to have_link category.name, count: 1
    end
  end

  context 'when category does not have a post' do
    it 'does not render a category link' do
      category = FactoryGirl.create(:category)

      render

      expect(rendered).not_to have_link category.name
    end
  end
end
