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

    fill_in attribute(:name), with: 'Ambiental Web'
    find('trix-editor').set('An awesome course about web development.')

    click_on I18n.t('helpers.submit.create', model: model_name)

    assert_current_path admin_courses_path
    assert_alert I18n.t('flash_messages.created', model: model_name)
    assert_text 'Ambiental Web'
  end

  test 'preventing invalid course creation' do
    visit new_admin_course_path

    click_on I18n.t('helpers.submit.create', model: model_name)

    assert_text blank_error_for(:name)
    assert_text blank_error_for(:description)
  end

  test 'updating a course' do
    visit edit_admin_course_path(@course)

    new_name = 'Updated course name'
    fill_in attribute(:name), with: new_name

    click_on I18n.t('helpers.submit.update', model: model_name)

    assert_current_path admin_courses_path
    assert_alert I18n.t('flash_messages.updated', model: model_name)
    assert_text new_name
  end

  test 'preventing invalid course updates' do
    visit edit_admin_course_path(@course)

    fill_in attribute(:name), with: ''
    click_on I18n.t('helpers.submit.update', model: model_name)

    assert_text blank_error_for(:name)
  end

  test 'deleting a course' do
    visit admin_courses_path

    within "tr#course_#{@course.id}" do
      link = find('a[data-turbo-method="delete"]')
      accept_confirm { link.click }
    end

    assert_alert I18n.t('flash_messages.destroyed', model: model_name)

    within '#courses_table' do
      assert_no_text @course.name
    end
  end

  test 'searching for a course' do
    FactoryBot.create_list(:course, 3)

    visit admin_courses_path

    fill_in 'search[term]', with: @course.name
    click_on 'search-button'

    assert_selector 'table tbody tr', count: 1
    assert_selector 'table tbody tr td', text: @course.name
  end

  private

  def blank_error_for(attribute)
    I18n.t('errors.messages.blank', attribute: Course.human_attribute_name(attribute))
  end

  def model_name
    Course.model_name.human
  end

  def attribute(attribute)
    Course.human_attribute_name(attribute)
  end
end
