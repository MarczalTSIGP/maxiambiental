require "test_helper"

class GoogleLoginFlowTest < ActionDispatch::IntegrationTest
  setup do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '123456789',
      info: {
        email: 'user@gmail.com',
        name: 'Test User'
      }
    })
  end

  test "admin can sign in with Google" do
    post admin_google_oauth2_omniauth_authorize_path
    assert_response :redirect

    follow_redirect!
    puts "Followed Redirect Status: #{response.inspect}"
    assert_response :success

    puts "Session: #{session.inspect}"
    assert_not_nil session['warden.user.admin.key']
    assert_equal 'user@example.com', Admin.find_by(email: 'user@example.com').email
  end

  test "should redirect to sign in on failure" do
    OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials

    post admin_google_oauth2_omniauth_authorize_path
    assert_response :redirect
    assert_redirected_to new_admin_session_path
  end
end
