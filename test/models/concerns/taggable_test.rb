# frozen_string_literal: true

require 'test_helper'

class TaggableTest < ActiveSupport::TestCase
  test 'tags' do
    tag = Tag.create(name: 'tag123')
    tag.taggings.create(account: accounts(:abdullah), taggable: ayahs(:ayah_1))

    assert_equal ['tag123'], ayahs(:ayah_1).tags.map(&:name)
  end
end
