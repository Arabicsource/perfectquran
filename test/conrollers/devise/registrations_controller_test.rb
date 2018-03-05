require 'test_helper'

class Devise::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test 'get new without account' do
    get new_account_registration_path
    assert_response :success
  end

  test 'get new with account' do
    login_as accounts(:abdullah)
    get new_account_registration_path
    assert_redirected_to root_path

    follow_redirect!
    assert_select '.notification', text: /You are already signed in/
  end

  test 'create account with empty params' do
    params = { account: { email: '' } }
    post account_registration_path, params: params

    assert_select '#error_explanation', text: /prohibited this account from being saved/
    assert_select '#error_explanation', text: /Email can't be blank/
    assert_select '#error_explanation', text: /Password can't be blank/
  end

  test 'create account with valid params' do
    params = { account:
               { email: 'example@perfectquran.co',
                 password: 'password',
                 password_confirmation: 'password' } }

    assert_difference 'Account.count', 1 do
      assert_difference 'Profile.count', 1 do
        assert_difference 'Account::EmailPreference.count', 1 do
          assert_difference 'ActionMailer::Base.deliveries.count', 1 do
            post account_registration_path, params: params
          end
        end
      end
    end

    assert_redirected_to root_path
  end
end
