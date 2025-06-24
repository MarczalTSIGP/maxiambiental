require 'test_helper'

class Admin::EnrollmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course_class = FactoryBot.create(:course_class, subscription_status: :open)
    @enrollments = FactoryBot.create_list(:enrollment, 5, course_class: @course_class)

    sign_in FactoryBot.create(:admin)
  end

  test 'should get index' do
    get admin_enrollments_url

    assert_response :success
  end

  test 'should get show' do
    get admin_enrollment_url(@enrollments.first)

    assert_response :success
  end
end
