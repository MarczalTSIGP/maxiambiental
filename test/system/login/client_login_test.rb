require 'application_system_test_case'

class ClientLoginTest < ApplicationSystemTestCase
  setup do
    @client = FactoryBot.create(:client)
  end

  test 'client can log in' do
    visit new_client_session_path

    fill_in :client_email, with: @client.email
    fill_in :client_password, with: 'password'
    click_on I18n.t('devise.sessions.sign_in')

    assert_current_path root_path
  end

  test 'client cannot log in with invalid credentials' do
    visit new_client_session_path

    fill_in :client_email, with: @client.email
    fill_in :client_password, with: 'wrongpassword'
    click_on I18n.t('devise.sessions.sign_in')

    assert_alert t('devise.failure.invalid', authentication_keys: 'E-mail')

    assert_current_path new_client_session_path
  end

  test 'client can navigate to forgot password page' do
    visit new_client_session_path

    click_on I18n.t('devise.sessions.forgot_password.title')

    assert_current_path new_client_password_path
  end
end
