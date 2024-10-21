require 'test_helper'

class Clients::Devise::SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client = FactoryBot.create(:client)
  end

  test 'should get new session page' do
    get new_client_session_path

    assert_response :success
  end

  test 'should login client with valid credentials' do
    post client_session_path, params: { client: { email: @client.email, password: @client.password } }

    assert_redirected_to root_path
    assert_equal t('devise.sessions.signed_in'), flash[:notice]
  end

  test 'should not login client with invalid credentials' do
    post client_session_path, params: { client: { email: @client.email, password: 'invalid' } }

    assert_response :unprocessable_entity
    assert_equal t('devise.failure.invalid', authentication_keys: 'E-mail'), flash[:alert]
  end

  test 'should logout client' do
    post client_session_path, params: { client: { email: @client.email, password: 'invalid' } }
    delete destroy_client_session_path

    assert_redirected_to new_client_session_path
    assert_nil session['warden.user.client.key']
    assert_equal t('devise.sessions.signed_out'), flash[:notice]
  end
end
