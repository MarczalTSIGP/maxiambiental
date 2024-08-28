require 'application_system_test_case'

class ResetPasswordsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  # def setup
  #   @admin = Admin.create!(
  #     email: "admin@example.com",
  #     password: "password",
  #     password_confirmation: "password"
  #   )
  # end

  # test "admin can request a password reset" do
  #   visit new_admin_password_path

  #   fill_in "Email", with: @admin.email
  #   click_on "Send me reset password instructions"

  #   assert_text "You will receive an email with instructions on how to reset your password in a few minutes."
  #   assert_not_nil @admin.reload.reset_password_token
  # end

  # test "admin can reset password with valid token" do
  #   @admin.send_reset_password_instructions

  #   token = @admin.reload.reset_password_token

  #   visit edit_admin_password_path(reset_password_token: token)

  #   fill_in "New password", with: "newpassword"
  #   fill_in "Confirm new password", with: "newpassword"
  #   click_on "Change my password"

  #   assert_text "Your password has been changed successfully. You are now signed in."

  #   sign_out @admin
  #   visit new_admin_session_path
  #   fill_in "Email", with: @admin.email
  #   fill_in "Password", with: "newpassword"
  #   click_on "Log in"

  #   assert_text "Signed in successfully."
  # end
end
