require 'test_helper'

class Study::TextsControllerTest < ActionDispatch::IntegrationTest
  test 'get show as json' do
    get '/study/texts/ayah/1/translation/1.json'
    assert_response :success
  end
end
