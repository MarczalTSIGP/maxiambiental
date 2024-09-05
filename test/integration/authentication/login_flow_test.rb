require 'test_helper'

class LoginFlowTest < ActionDispatch::IntegrationTest
  include ActionView::Helpers::TranslationHelper

  setup do
    @admin = FactoryBot.create(:admin)
  end

  test 'admin login page' do
    get new_admin_session_path

    assert_response :success

    assert_select 'h1', 'Entrar'
  end

  test 'admin login with valid credentials' do
    post admin_session_path, params: { admin: { email: @admin.email, password: 'password' } }

    assert_redirected_to admin_root_path

    follow_redirect!

    assert_response :success
    assert_select 'span', @admin.email
  end

  test 'admin login with invalid credentials' do
    get new_admin_session_path

    assert_response :success

    post admin_session_path, params: { admin: { email: @admin.email, password: 'wrong_password' } }

    assert_response :unprocessable_entity

    assert_select 'div', t('devise.failure.invalid', authentication_keys: 'Email')
  end

  test 'admin login with empty credentials' do
    get new_admin_session_path

    assert_response :success

    post admin_session_path, params: { admin: { email: '', password: '' } }

    assert_response :unprocessable_entity

    assert_select 'div', t('devise.failure.invalid', authentication_keys: 'Email')
  end
end
