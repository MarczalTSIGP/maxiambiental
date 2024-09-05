require 'application_system_test_case'

class AdminLoginTest < ApplicationSystemTestCase
  include ActionView::Helpers::TranslationHelper

  setup do
    @admin = FactoryBot.create(:admin)
  end

  test 'admin can log in' do
    visit new_admin_session_path

    fill_in t('email'), with: @admin.email
    fill_in t('password'), with: 'password'
    click_on t('devise.sessions.sign_in')

    assert_current_path admin_root_path
  end

  test 'admin cannot log in with invalid credentials' do
    visit new_admin_session_path

    fill_in t('email'), with: @admin.email
    fill_in t('password'), with: 'wrongpassword'
    click_on t('devise.sessions.sign_in')

    assert_text t('devise.failure.invalid', authentication_keys: 'Email')
    assert_current_path new_admin_session_path
  end
end
