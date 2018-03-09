# frozen_string_literal: true

require 'test_helper'

class TagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @url = tags_path
    @valid_params = { tag:
      { taggable_id: 1, taggable_type: 'Ayah', name: 'abc123' } }
    @invalid_params = {
      tag: { taggable_id: 1, taggable_type: 'Ayah', name: '' }
    }
  end

  test 'post create without account' do
    post @url, params: @valid_params
    assert_redirected_to new_account_session_path
  end

  test 'post create with account and invalid params' do
    login_as accounts(:abdullah)
    post @url, params: @invalid_params
    assert Tag.count.zero?
    assert Tagging.count.zero?
    assert_redirected_to ayahs(:ayah_1)

    follow_redirect!
    assert_select '.notification', text: /Name can't be blank/
  end

  test 'post create with account and valid params' do
    login_as accounts(:abdullah)
    post @url, params: @valid_params
    assert_equal 1, Tag.count
    assert_equal 1, Tagging.count
    assert_redirected_to ayahs(:ayah_1)

    follow_redirect!
    assert_select '#tag-list', text: /abc123/
    assert_select '.notification', text: /Alhamdulillah, the tag was added/
  end

  test 'post create with account and valid but duplicate params' do
    login_as accounts(:abdullah)
    post @url, params: @valid_params

    post @url, params: @valid_params
    assert_redirected_to ayahs(:ayah_1)

    follow_redirect!
    assert_select '.notification', text: /has already been used/
  end
end
