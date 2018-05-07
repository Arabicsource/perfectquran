# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'meta_description' do
    specify { expect(helper.meta_description('a' * 160)).to eq 'a' * 160 }

    specify do
      expect(helper.meta_description('a' * 200)).to eq 'a' * 157 + '...'
    end
  end

  describe '#page_title' do
    it 'returns `PerfectQuran` when called without arguments' do
      expect(helper.page_title).to eq 'PerfectQuran'
    end

    it 'returns `Title | PerfectQuran` when called with an argument' do
      expect(helper.page_title('Title')).to eq 'Title | PerfectQuran'
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
