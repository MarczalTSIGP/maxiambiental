require 'application_system_test_case'

class Admin::CoursesTest < ApplicationSystemTestCase
  setup do
    @admin = create(:admin)
    @course = create(:course)
    login_as(@admin, scope: :admin)
  end

  test 'viewing courses index' do
    visit admin_courses_path

    assert_selector 'h1', text: I18n.t('admin.courses.index.title')
    assert_selector 'table tbody tr', count: Course.count
    assert_selector 'table tbody tr td', text: @course.name
  end

  test 'creating a course' do
    visit new_admin_course_path

    fill_in Course.human_attribute_name(:name), with: 'Ambiental Web'
    fill_in Course.human_attribute_name(:description), with: 'An awesome course about web development'

    click_on I18n.t('helpers.submit.create', model: Course.model_name.human)

    assert_current_path admin_courses_path
    assert_alert I18n.t('flash_messages.created', model: Course.model_name.human)
    assert_text 'An awesome course about web development'
  end

  test 'preventing invalid course creation' do
    visit new_admin_course_path

    click_on I18n.t('helpers.submit.create', model: Course.model_name.human)

    assert_text blank_error_for(:name)
    assert_text blank_error_for(:description)
  end

  test 'updating a course' do
    visit edit_admin_course_path(@course)

    new_name = 'Updated course name'
    fill_in Course.human_attribute_name(:name), with: new_name

    click_on I18n.t('helpers.submit.update', model: Course.model_name.human)

    assert_current_path admin_courses_path
    assert_alert I18n.t('flash_messages.updated', model: Course.model_name.human)
    assert_text new_name
  end

  test 'preventing invalid course updates' do
    visit edit_admin_course_path(@course)

    fill_in Course.human_attribute_name(:name), with: ''
    click_on I18n.t('helpers.submit.update', model: Course.model_name.human)

    assert_text blank_error_for(:name)
  end

  test 'deleting a course' do
    visit admin_courses_path

    within "tr#course_#{@course.id}" do
      link = find('a[data-turbo-method="delete"]')
      accept_confirm { link.click }
    end

    assert_alert I18n.t('flash_messages.destroyed', model: Course.model_name.human)

    within '#courses_table' do
      assert_no_text @course.name
    end
  end

  private

  def blank_error_for(attribute)
    I18n.t('errors.messages.blank', attribute: Course.human_attribute_name(attribute))
  end
end
