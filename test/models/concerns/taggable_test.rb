# frozen_string_literal: true

require 'test_helper'

class TaggableTest < ActiveSupport::TestCase
  test 'tags' do
    tag = Tag.create(name: 'tag123')
    tag.taggings.create(account: accounts(:abdullah), taggable: Quran::Ayah.first)

    assert_equal ['tag123'], Quran::Ayah.first.tags.map(&:name)
  end
end
