require 'test_helper'

class Admin::Devise::SessionsControllerTest < ActionDispatch::IntegrationTest
  include ActionView::Helpers::TranslationHelper

  setup do
    @admin = FactoryBot.create(:admin)
  end

  test 'should get new session page' do
    get new_admin_session_path

    assert_response :success
  end

  test 'should login admin with valid credentials' do
    post admin_session_path, params: { admin: { email: @admin.email, password: @admin.password } }

    assert_redirected_to admin_root_path
    assert_equal t('devise.sessions.signed_in'), flash[:notice]
  end

  test 'should not login admin with invalid credentials' do
    post admin_session_path, params: { admin: { email: @admin.email, password: 'invalid' } }

    assert_response :unprocessable_entity
    assert_equal t('devise.failure.invalid', authentication_keys: 'E-mail'), flash[:alert]
  end

  test 'should logout admin' do
    post admin_session_path, params: { admin: { email: @admin.email, password: 'invalid' } }
    delete destroy_admin_session_path

    assert_redirected_to new_admin_session_path
    assert_nil session['warden.user.admin.key']
    assert_equal t('devise.sessions.signed_out'), flash[:notice]
  end
end
