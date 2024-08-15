require "test_helper"

class Admin::Devise::SessionsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = FactoryBot.create(:user)
  end

  test "should get new" do
    get new_admin_user_session_path
    assert_response :success
  end

  test "should login user" do
    post admin_user_session_path, params: { user: { email: @user.email, password: @user.password } }
    assert_redirected_to root_path
    assert_equal @user.id, session["warden.user.user.key"][0][0]
  end

  test "should not login user with invalid credentials" do
    post admin_user_session_path, params: { user: { email: @user.email, password: "invalid" } }
    assert_response :unprocessable_entity
    assert_nil session["warden.user.user.key"]
  end
end
