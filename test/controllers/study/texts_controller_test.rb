# frozen_string_literal: true

require 'test_helper'

module Study
  class TextsControllerTest < ActionDispatch::IntegrationTest
    test 'get show as json' do
      get '/study/texts/ayah/1/translation/1.json'
      assert_response :success
    end
  end
end
