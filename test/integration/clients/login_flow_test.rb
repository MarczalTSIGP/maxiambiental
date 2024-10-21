require 'test_helper'

class Clients::LoginFlowTest < ActionDispatch::IntegrationTest
  setup do
    @client = FactoryBot.create(:client)
  end

  test 'should display client login page' do
    get new_client_session_path

    assert_response :success

    assert_select 'h1.text-green-700', t('devise.sessions.sign_in')
  end

  test 'should login client with valid credentials' do
    post client_session_path, params: { client: { email: @client.email, password: 'password' } }

    assert_redirected_to root_path

    follow_redirect!

    assert_response :success
    assert_select 'span', @client.email
  end

  test 'should not login client with invalid credentials' do
    get new_client_session_path

    assert_response :success

    post client_session_path, params: { client: { email: @client.email, password: 'wrong_password' } }

    assert_response :unprocessable_entity

    assert_select '[data-alert-target="alert"]', t('devise.failure.invalid', authentication_keys: 'E-mail')
  end

  test 'should not login client with empty credentials' do
    get new_client_session_path

    assert_response :success

    post client_session_path, params: { client: { email: '', password: '' } }

    assert_response :unprocessable_entity

    assert_select '[data-alert-target="alert"]', t('devise.failure.invalid', authentication_keys: 'E-mail')
  end
end
