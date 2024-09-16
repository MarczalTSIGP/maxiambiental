require 'application_system_test_case'

class ResetPasswordsTest < ApplicationSystemTestCase
  setup do
    @admin = FactoryBot.create(:admin)
  end

  test 'admin can ask instruction by email to reset password' do
    visit new_admin_password_path

    fill_in :admin_email, with: @admin.email
    click_on t('devise.sessions.forgot_password.button')

    assert_current_path new_admin_password_path

    assert_alert t('devise.passwords.send_instructions')
  end

  test 'admin can reset password with valid token' do
    token = @admin.send_reset_password_instructions

    visit edit_admin_password_path(reset_password_token: token)

    fill_in :admin_password, with: 'newpassword'
    fill_in :admin_password_confirmation, with: 'newpassword'
    click_on t('devise.sessions.reset_password.button')

    assert_current_path admin_root_path
    sign_out @admin
  end

  test 'cannot reset password with invalid email' do
    visit new_admin_session_path

    click_on t('devise.sessions.forgot_password.title')

    assert_current_path new_admin_password_path

    fill_in :admin_email, with: 'invalid@example.com'
    click_on t('devise.sessions.forgot_password.button')

    assert_selector 'p', text: I18n.t('errors.messages.not_found', attribute: 'E-mail')
    assert_nil @admin.reload.reset_password_token
  end

  test 'cannot reset password with invalid token' do
    visit edit_admin_password_path(reset_password_token: 'invalidtoken')

    fill_in :admin_password, with: 'newpassword'
    fill_in :admin_password_confirmation, with: 'newpassword'
    click_on t('devise.sessions.reset_password.button')

    assert_selector 'p', text: t('devise.passwords.token_invalid')
    assert_current_path edit_admin_password_path(reset_password_token: 'invalidtoken')
  end

  test 'cannot reset password with mismatched passwords' do
    token = @admin.send_reset_password_instructions

    visit edit_admin_password_path(reset_password_token: token)

    fill_in :admin_password, with: 'newpassword'
    fill_in :admin_password_confirmation, with: 'differentpassword'
    click_on t('devise.sessions.reset_password.button')

    assert_selector 'p', text: t('errors.messages.confirmation', attribute: Admin.human_attribute_name(:password))
    assert_current_path edit_admin_password_path(reset_password_token: token)
  end
end
