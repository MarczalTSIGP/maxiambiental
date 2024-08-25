require 'test_helper'

class Admin::Devise::SessionsControllerTest < ActionDispatch::IntegrationTest
  include ActionView::Helpers::TranslationHelper

  setup do
    @admin = FactoryBot.create(:admin)
  end

  test 'should get new' do
    get new_admin_session_path

    assert_response :success
  end

  test 'should login user' do
    post admin_session_path, params: { admin: { email: @admin.email, password: @admin.password } }

    assert_redirected_to root_path
    assert_equal t('devise.sessions.signed_in'), flash[:notice]
  end

  test 'should not login user with invalid credentials' do
    post admin_session_path, params: { admin: { email: @admin.email, password: 'invalid' } }

    assert_response :unprocessable_entity
    assert_equal t('devise.failure.invalid', authentication_keys: 'Email'), flash[:alert]
  end

  test 'should logout user' do
    post admin_session_path, params: { admin: { email: @admin.email, password: 'invalid' } }
    delete destroy_admin_session_path

    assert_redirected_to root_path
    assert_nil session['warden.user.admin.key']
    assert_equal t('devise.sessions.signed_out'), flash[:notice]
  end
end
