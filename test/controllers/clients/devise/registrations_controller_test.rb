require 'test_helper'

class Clients::Devise::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new registration page' do
    get new_client_registration_path

    assert_response :success
  end

  test 'should register client with valid credentials' do
    post client_registration_path,
         params: { client: { email: 'client@maxiambiental.com',
                             name: 'Client',
                             password: 'password',
                             password_confirmation: 'password' } }

    assert_redirected_to new_client_session_path
    assert_equal t('devise.registrations.signed_up_but_unconfirmed'), flash[:notice]
  end

  test 'should not register client with invalid email' do
    post client_registration_path,
         params: { client: { email: 'client.com',
                             name: 'client',
                             password: 'password',
                             password_confirmation: 'password' } }

    assert_response :unprocessable_entity
    assert_select 'p.text-red-600', t('errors.messages.invalid', attribute: 'E-mail')
  end

  test 'should not register client with invalid password' do
    post client_registration_path,
         params: { client: { email: 'client@maxiambiental.com',
                             name: 'Client',
                             password: 'pass',
                             password_confirmation: 'password' } }

    assert_response :unprocessable_entity

    assert_select 'p.text-red-600',
                  t('errors.messages.too_short',
                    attribute: t('activerecord.attributes.client.password'), count: 6)
  end

  test 'should not register client with non matching password confirmation' do
    post client_registration_path,
         params: { client: { email: 'client@maxiambiental.com',
                             name: 'Client',
                             password: 'password',
                             password_confirmation: 'passwor' } }

    assert_response :unprocessable_entity

    assert_select 'p.text-red-600',
                  t('errors.messages.confirmation',
                    attribute: t('activerecord.attributes.client.password'))
  end
end
