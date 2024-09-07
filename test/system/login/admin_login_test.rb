require 'application_system_test_case'

class AdminLoginTest < ApplicationSystemTestCase
  setup do
    @admin = FactoryBot.create(:admin)
  end

  test 'admin can log in' do
    visit new_admin_session_path

    fill_in label('email'), with: @admin.email
    fill_in label('password'), with: 'password'
    click_on I18n.t('devise.sessions.sign_in')

    assert_current_path admin_root_path
  end

  test 'admin cannot log in with invalid credentials' do
    visit new_admin_session_path

    fill_in label('email'), with: @admin.email
    fill_in label('password'), with: 'wrongpassword'
    click_on I18n.t('devise.sessions.sign_in')

    assert_text t('devise.failure.invalid', authentication_keys: 'E-mail')
    assert_current_path new_admin_session_path
  end

  private

  def label(attribute)
    Admin.human_attribute_name attribute
  end
end
