require 'test_helper'

class Admin::Devise::PasswordControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = FactoryBot.create(:admin)
  end

  test 'should get new' do
    get new_admin_password_path

    assert_response :success

    assert_select 'h1', 'Redefinir senha'
  end

  test 'should send reset password instructions' do
    post admin_password_path, params: { admin: { email: @admin.email } }

    assert_redirected_to new_admin_session_path
    follow_redirect!

    assert_not_empty ActionMailer::Base.deliveries
    assert_equal 'Você receberá um email com instruções sobre como redefinir sua senha em alguns minutos.',
                 flash[:notice]
  end

  test 'should not send reset password instructions for invalid email' do
    post admin_password_path, params: { admin: { email: 'invalid@example.com' } }

    assert_response :unprocessable_content
    assert_empty ActionMailer::Base.deliveries
    assert_select 'p', 'E-mail não encontrado'
  end

  test 'should get edit with valid token' do
    @admin.send_reset_password_instructions
    reset_token = @admin.reload.reset_password_token

    get edit_admin_password_path(reset_password_token: reset_token)

    assert_response :success
    assert_select 'h1', 'Redefinir senha'
  end

  # test "should not get edit with invalid token" do
  #   get edit_admin_password_path(reset_password_token: 'invalidtoken')
  #   assert_redirected_to new_admin_password_path
  #   follow_redirect!
  #   assert_equal 'O token de redefinição de senha é inválido ou expirou.', flash[:alert]
  # end

  # test "should update password with valid token" do
  #   @admin.send_reset_password_instructions
  #   reset_token = @admin.reload.reset_password_token

  #   patch admin_password_path, params: {
  #     admin: {
  #       reset_password_token: reset_token,
  #       password: 'newpassword',
  #       password_confirmation: 'newpassword'
  #     }
  #   }

  #   assert_redirected_to admin_root_path
  #   follow_redirect!

  #   assert @admin.reload.valid_password?('newpassword')
  # end
end
