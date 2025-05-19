require 'test_helper'

class Admin::CourseClassesAuthorizationTest < ActionDispatch::IntegrationTest
  test 'should not get index without login' do
    get admin_course_classes_path

    assert_unauthenticated
  end

  test 'should not get new without login' do
    get new_admin_course_class_path

    assert_unauthenticated
  end

  test 'should not get edit without login' do
    course_class = FactoryBot.create(:course_class)

    get edit_admin_course_class_path(course_class)

    assert_unauthenticated
  end

  test 'should not create without login' do
    post admin_course_classes_path, params: { course_class: { name: 'test' } }

    assert_unauthenticated
  end

  test 'should not update without login' do
    course_class = FactoryBot.create(:course_class)

    patch admin_course_class_path(course_class), params: { course_class: { name: 'test' } }

    assert_unauthenticated
  end

  private

  def assert_unauthenticated
    assert_response :redirect
    assert_equal I18n.t('devise.failure.unauthenticated'), flash[:alert]
  end
end
