# frozen_string_literal: true

require 'rails_helper'

describe 'blog/shared/_categories_menu' do
  context 'when category has posts' do
    it 'renders a category link once' do
      FactoryBot.create_list(
        :post, 3, category: FactoryBot.create(:category, name: 'Abc123')
      )

      render

      expect(rendered).to have_link 'Abc123', count: 1
    end
  end

  context 'when category does not have a post' do
    it 'does not render a category link' do
      FactoryBot.create(:category, name: 'Abc123')

      render

      expect(rendered).not_to have_link 'Abc123'
    end
  end
end
