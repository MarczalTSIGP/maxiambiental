# test/controllers/admin/courses_controller_test.rb

require 'test_helper'

class Admin::CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = FactoryBot.create(:admin)
    sign_in @admin
  end

  # Index Action
  test 'should get index' do
    courses = FactoryBot.create_list(:course, 3)

    get admin_courses_path

    assert_response :success
    courses.each { |course| assert_match course.name, response.body }
  end

  # New Action
  test 'should get new' do
    get new_admin_course_path

    assert_response :success
    assert_select 'form[action=?]', admin_courses_path
  end

  # Create Action
  test 'should create course with valid params' do
    valid_attributes = FactoryBot.attributes_for(:course)

    assert_difference('Course.count') do
      post admin_courses_path, params: { course: valid_attributes }
    end

    assert_redirected_to admin_courses_path
    assert_equal I18n.t('flash_messages.created', model: Course.model_name.human), flash[:notice]
  end

  test 'should not create course with invalid params' do
    invalid_attributes = { name: '', description: '' }

    assert_no_difference('Course.count') do
      post admin_courses_path, params: { course: invalid_attributes }
    end

    assert_response :unprocessable_entity

    [:name, :description].each do |attribute|
      assert_includes response.body, blank_error_for(attribute)
    end
  end

  # Show Action
  test 'should show course' do
    course = FactoryBot.create(:course)

    get admin_course_path(course)

    assert_response :success
    assert_select 'h1', course.name
  end

  # Edit Action
  test 'should get edit' do
    course = FactoryBot.create(:course)

    get edit_admin_course_path(course)

    assert_response :success
    assert_select 'form[action=?]', admin_course_path(course)
  end

  # Update Action
  test 'should update course with valid params' do
    course = FactoryBot.create(:course, name: 'Old Name')
    valid_attributes = { name: 'New Name' }

    patch admin_course_path(course), params: { course: valid_attributes }

    assert_redirected_to admin_courses_path
    course.reload

    assert_equal 'New Name', course.name
    assert_equal I18n.t('flash_messages.updated', model: Course.model_name.human), flash[:notice]
  end

  test 'should not update course with invalid params' do
    course = FactoryBot.create(:course, name: 'Valid Name')

    patch admin_course_path(course), params: { course: { name: '' } }

    assert_response :unprocessable_entity
    course.reload

    assert_equal 'Valid Name', course.name

    assert_includes response.body, blank_error_for(:name)
  end

  # Destroy Action
  test 'should delete course' do
    course = FactoryBot.create(:course)

    assert_difference('Course.count', -1) do
      delete admin_course_path(course)
    end

    assert_redirected_to admin_courses_path
    assert_equal 'Course was successfully deleted.', flash[:notice]
  end

  # Authorization Tests
  test 'should redirect non-admin users' do
    sign_out @admin
    client = FactoryBot.create(:client)
    sign_in client

    get new_admin_course_path

    assert_redirected_to new_admin_session_path
  end

  private

  def blank_error_for(attribute)
    I18n.t('errors.messages.blank', attribute: Course.human_attribute_name(attribute))
  end
end
