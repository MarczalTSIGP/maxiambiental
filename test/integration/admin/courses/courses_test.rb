require 'test_helper'

class CoursesTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @admin = create(:admin)
    @course = create(:course)
    @valid_params = { name: 'Valid name', description: Faker::Lorem.sentence }
    sign_in @admin
  end

  context 'GET actions' do
    should 'render index' do
      get admin_courses_path

      assert_response :success
      assert_select 'h1', I18n.t('admin.courses.index.title')
    end

    should 'render new' do
      get new_admin_course_path

      assert_form_rendered(new: true)
    end

    should 'render edit' do
      get edit_admin_course_path(@course)

      assert_form_rendered
    end
  end

  context 'POST create' do
    should 'create with valid params' do
      assert_difference('Course.count') do
        post admin_courses_path, params: { course: @valid_params }
      end

      assert_redirected_with_flash :created
    end

    should 'reject invalid params' do
      assert_no_difference('Course.count') do
        post admin_courses_path, params: { course: { name: '' } }
      end
      assert_form_errors(:name)
    end
  end

  context 'PATCH update' do
    should 'update with valid params' do
      new_name = 'New course name'

      patch admin_course_path(@course),
            params: { course: @valid_params.merge(name: new_name) }

      assert_redirected_with_flash(:updated)
      assert_equal new_name, @course.reload.name
    end

    should 'reject invalid params' do
      patch admin_course_path(@course), params: { course: { name: '' } }

      assert_form_errors(:name)
    end
  end

  context 'DELETE destroy' do
    should 'delete course' do
      assert_difference('Course.count', -1) do
        delete admin_course_path(@course)
      end
      assert_redirected_with_flash(:destroyed)
    end
  end

  private

  def assert_form_rendered(new: false)
    assert_response :success
    assert_select 'form[action=?]', new ? admin_courses_path : admin_course_path(@course)
  end

  def assert_redirected_with_flash(action)
    assert_redirected_to admin_courses_path
    follow_redirect!

    assert_flash_message(model: Course.model_name.human, action: action)
  end

  def assert_form_errors(*attributes)
    assert_response :unprocessable_entity

    attributes.each do |attr|
      assert_select 'p.text-red-600',
                    text: I18n.t('errors.messages.blank', attribute: Course.human_attribute_name(attr))
    end
  end

  def assert_flash_message(options)
    assert_select 'div[data-alert-target="alert"]',
                  text: I18n.t("flash_messages.#{options[:action]}", **options)
  end
end
