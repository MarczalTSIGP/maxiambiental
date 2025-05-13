require 'test_helper'

class Admin::CourseClassesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in FactoryBot.create(:admin)
  end

  test 'should get new' do
    get new_admin_course_class_path

    assert_response :success
  end

  test 'should create a class with valid params' do
    post admin_course_classes_path, params: { course_class: valid_params }

    assert_response :redirect
  end

  test 'should not create a class with invalid params' do
    post admin_course_classes_path, params: { course_class: { name: '' } }

    assert_response :unprocessable_entity

    assert_select 'p.text-red-600',
                  text: I18n.t('errors.messages.blank', attribute: CourseClass.human_attribute_name(:name))
  end

  private

  def valid_params
    FactoryBot.attributes_for(:course_class).merge(
      course_id: FactoryBot.create(:course).id,
      instructor_id: FactoryBot.create(:instructor).id
    )
  end
end
