require 'test_helper'

class Admin::DashboardControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = FactoryBot.create(:admin)
    sign_in @admin
  end

  test 'should get index' do
    get admin_root_path

    assert_response :success
  end
end
