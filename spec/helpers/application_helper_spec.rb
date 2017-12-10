# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#page_title' do
    it 'returns `Perfect Quran` when called without arguments' do
      expect(helper.page_title).to eq 'Perfect Quran'
    end

    it 'returns `Title | Perfect Quran` when called with an argument' do
      expect(helper.page_title('Title')).to eq 'Title | Perfect Quran'
    end
  end

  describe '#menu' do
    it 'returns nil if no menu with given name exisits' do
      expect(helper.menu('nonexistant')).to be_nil
    end

    it 'has a menu label that is the menu name when no label is provided' do
      create :menu, name: 'menu123'

      expect(helper.menu('menu123')).to have_css 'p.menu-label', text: 'menu123'
    end

    it 'has a menu label' do
      create :menu, name: 'menu123'

      expect(helper.menu('menu123', 'label123')).to(
        have_css('p.menu-label', text: 'label123')
      )
    end

    it 'has a menu link' do
      menu = create :menu, name: 'menu123'
      create :menu_link, menu: menu, name: 'link123', path: 'path123'

      expect(helper.menu('menu123')).to have_link 'link123', href: 'path123'
    end
  end

  describe '#markdown' do
    it 'filters **' do
      text = '**bold**'

      expect(helper.markdown(text)).to include '<strong>bold</strong>'
    end

    it 'filters *' do
      text = '*emph*'

      expect(helper.markdown(text)).to include '<em>emph</em>'
    end

    it 'autolinks' do
      text = 'http://a.com'

      expect(helper.markdown(text))
        .to include('<a href="http://a.com">http://a.com</a>')
    end
  end
end
