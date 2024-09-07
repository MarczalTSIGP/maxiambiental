require 'test_helper'

class LoginFlowTest < ActionDispatch::IntegrationTest
  setup do
    @admin = FactoryBot.create(:admin)
  end

  test 'should display admin login page' do
    get new_admin_session_path

    assert_response :success

    assert_select 'h1', t('devise.sessions.sign_in')
  end

  test 'should login admin with valid credentials' do
    post admin_session_path, params: { admin: { email: @admin.email, password: 'password' } }

    assert_redirected_to admin_root_path

    follow_redirect!

    assert_response :success
    assert_select 'span', @admin.email
  end

  test 'should not login admin with invalid credentials' do
    get new_admin_session_path

    assert_response :success

    post admin_session_path, params: { admin: { email: @admin.email, password: 'wrong_password' } }

    assert_response :unprocessable_entity

    assert_select '[data-alert-target="alert"]', t('devise.failure.invalid', authentication_keys: 'E-mail')
  end

  test 'should not login admin with empty credentials' do
    get new_admin_session_path

    assert_response :success

    post admin_session_path, params: { admin: { email: '', password: '' } }

    assert_response :unprocessable_entity

    assert_select '[data-alert-target="alert"]', t('devise.failure.invalid', authentication_keys: 'E-mail')
  end
end
