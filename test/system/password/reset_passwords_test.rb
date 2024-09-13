require 'application_system_test_case'

class ResetPasswordsTest < ApplicationSystemTestCase
  setup do
    @admin = FactoryBot.create(:admin)
  end

  test 'admin can ask instruction by email to reset password' do
    visit new_admin_password_path

    fill_in :admin_email, with: @admin.email
    click_on I18n.t('devise.sessions.forgot_password.button')

    assert_current_path new_admin_password_path

    assert_alert I18n.t('devise.passwords.send_instructions')
  end

  # test "admin can reset password with valid token" do
  #   @admin.send_reset_password_instructions

  #   token = @admin.reload.reset_password_token

  #   visit edit_admin_password_path(reset_password_token: token)

  #   fill_in label("password"), with: "newpassword"
  #   fill_in label("password_confirmation"), with: "newpassword"
  #   click_on I18n.t('authentication.reset_password.title')

  #   assert_current_path admin_root_path
  #   sign_out @admin
  # end

  # test "cannot reset password with invalid email" do
  #   visit new_admin_session_path

  #   click_on I18n.t('devise.sessions.forgot_password')

  #   assert_current_path new_admin_password_path

  #   fill_in label('email'), with: "invalid@example.com"
  #   click_on I18n.t('buttons.send')

  #   assert_text I18n.t('devise.errors.messages.not_found', attribute: 'E-mail')
  #   assert_nil @admin.reload.reset_password_token
  # end

  # test "cannot reset password with invalid token" do
  #   visit edit_admin_password_path(reset_password_token: "invalidtoken")

  #   fill_in label("password"), with: "newpassword"
  #   fill_in label("password_confirmation"), with: "newpassword"
  #   click_on I18n.t('authentication.reset_password.title')

  #   assert_text I18n.t('devise.passwords.token_invalid')
  #   assert_current_path edit_admin_password_path(reset_password_token: "invalidtoken")
  # end

  # test "cannot reset password with mismatched passwords" do
  #   @admin.send_reset_password_instructions

  #   token = @admin.reload.reset_password_token

  #   visit edit_admin_password_path(reset_password_token: token)

  #   fill_in label("password"), with: "newpassword"
  #   fill_in label("password_confirmation"), with: "differentpassword"
  #   click_on I18n.t('authentication.reset_password.title')

  #   assert_text I18n.t('errors.messages.confirmation', attribute: 'Password')
  #   assert_current_path edit_admin_password_path(reset_password_token: token)
  # end
end
