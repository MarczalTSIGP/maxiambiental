require 'test_helper'

class Admin::CourseClassesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = FactoryBot.create(:admin)
    sign_in @admin
    @course = FactoryBot.create(:course)
    @instructor = FactoryBot.create(:instructor)
    @course_class = FactoryBot.create(:course_class, course: @course, instructor: @instructor)
  end

  # Index action
  test 'should get index' do
    get admin_course_classes_path

    assert_response :success
    assert_select 'h1', text: I18n.t('admin.course_classes.index.title')
  end

  # New action
  test 'should get new' do
    get new_admin_course_class_path

    assert_response :success
    assert_select 'form[action=?]', admin_course_classes_path
  end

  # Create action
  test 'should create course_class with valid params' do
    assert_difference('CourseClass.count') do
      post admin_course_classes_path, params: { course_class: valid_params }
    end

    assert_redirected_to admin_course_classes_path
    follow_redirect!

    assert_equal flash[:notice], t('flash_messages.created', model: CourseClass.model_name.human)
  end

  test 'should not create course_class with invalid params' do
    assert_no_difference('CourseClass.count') do
      post admin_course_classes_path, params: { course_class: invalid_params }
    end

    assert_response :unprocessable_entity
    assert_select 'p.text-red-600',
                  text: I18n.t('errors.messages.blank', attribute: CourseClass.human_attribute_name(:name))
  end

  # Show action
  test 'should show course_class' do
    get admin_course_class_path(@course_class)

    assert_response :success
    assert_select 'h1', text: @course_class.name
  end

  # Edit action
  test 'should get edit' do
    get edit_admin_course_class_path(@course_class)

    assert_response :success
    assert_select 'form[action=?]', admin_course_class_path(@course_class)
  end

  # Update action
  test 'should update course_class with valid params' do
    new_name = 'Updated Class Name'
    patch admin_course_class_path(@course_class), params: { course_class: { name: new_name } }

    assert_equal flash[:notice], t('flash_messages.updated', model: CourseClass.model_name.human)
    @course_class.reload

    assert_equal new_name, @course_class.name
  end

  test 'should not update course_class with invalid params' do
    original_name = @course_class.name
    patch admin_course_class_path(@course_class), params: { course_class: { name: '' } }

    assert_response :unprocessable_entity
    @course_class.reload

    assert_equal original_name, @course_class.name
    assert_select 'p.text-red-600',
                  text: I18n.t('errors.messages.blank', attribute: CourseClass.human_attribute_name(:name))
  end

  private

  def valid_params
    FactoryBot.attributes_for(:course_class).merge(
      course_id: @course.id,
      instructor_id: @instructor.id,
      start_date: Time.zone.today + 1.week,
      end_date: Time.zone.today + 3.months
    )
  end

  def invalid_params
    { name: '', course_id: nil, instructor_id: nil }
  end
end
