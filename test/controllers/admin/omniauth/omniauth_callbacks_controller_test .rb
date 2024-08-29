require "test_helper"

class Admin::Omniauth::OmniauthCallbacksControllerTest < ActionDispatch::IntegrationTest
  test "should sign in admin with Google" do
    @admin = admins(:one)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '123456789',
      info: {
        email: @admin.email,
        name: 'Test User'
      }
    })

    get user_google_oauth2_omniauth_authorize_path
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal @admin.id, session['warden.user.admin.key'].first
  end

  test "should redirect to sign in on failure" do
    OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
    get user_google_oauth2_omniauth_authorize_path
    assert_response :redirect
    assert_redirected_to new_admin_session_path
  end
end
