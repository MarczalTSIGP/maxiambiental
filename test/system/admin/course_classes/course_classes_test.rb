require 'application_system_test_case'

class Admin::CourseClassesTest < ApplicationSystemTestCase
  setup do
    sign_in_as_admin
  end

  test 'visiting the index' do
    visit admin_course_classes_url

    assert_selector 'h1', text: I18n.t('admin.course_classes.index.title')
    assert_selector 'table#course_classes_table'
  end

  test 'showing a list of course classes' do
    course_class = FactoryBot.create(:course_class)

    visit admin_course_classes_url

    within 'table#course_classes_table' do
      assert_text course_class.name
      assert_text course_class.instructor.name
      assert_text course_class.course.name
    end
  end

  test 'creating a course class' do
    instructors = FactoryBot.create_list(:instructor, 5)
    course = FactoryBot.create_list(:course, 5)

    course_class = FactoryBot.build(:course_class)

    visit new_admin_course_class_url

    fill_in 'course_class[name]', with: course_class.name

    select course.first.name, from: 'course_class[course_id]'
    select instructors.first.name, from: 'course_class[instructor_id]'

    select_date 'start_at', course_class.start_at
    select_date 'end_at', course_class.end_at

    fill_in 'course_class[address]', with: course_class.address
    fill_in 'course_class[schedule]', with: course_class.schedule

    fill_rich_text_area '#course_class_about', course_class.about
    fill_rich_text_area '#course_class_programming', course_class.programming
    fill_rich_text_area '#course_class_payments_info', course_class.payments_info

    click_on I18n.t('helpers.submit.create', model: CourseClass.model_name.human)

    assert_alert I18n.t('flash_messages.created', model: CourseClass.model_name.human)
  end

  test 'attempting to create a course class with errors' do
    visit new_admin_course_class_url

    fill_in 'course_class[name]', with: ''

    click_on I18n.t('helpers.submit.create', model: CourseClass.model_name.human)

    assert_validation_error I18n.t('errors.messages.blank', attribute: CourseClass.human_attribute_name(:name))
  end

  test 'updating a course class' do
    course_class = FactoryBot.create(:course_class)

    visit edit_admin_course_class_url(course_class)

    fill_in 'course_class[name]', with: 'New name'

    click_on I18n.t('helpers.submit.update', model: CourseClass.model_name.human)

    assert_alert I18n.t('flash_messages.updated', model: CourseClass.model_name.human)
  end

  test 'attempting to update a course class with errors' do
    course_class = FactoryBot.create(:course_class)

    visit edit_admin_course_class_url(course_class)

    fill_in 'course_class[name]', with: ''

    click_on I18n.t('helpers.submit.update', model: CourseClass.model_name.human)

    assert_validation_error I18n.t('errors.messages.blank', attribute: CourseClass.human_attribute_name(:name))
  end

  private

  def fill_rich_text_area(selector, content)
    find(selector).set(content)
  end

  def select_date(attribute, date_time)
    date, time = date_time.strftime('%Y-%m-%d %H:%M').split
    year, month, day = date.split('-')
    hour, min = time.split(':')

    select year, from: "course_class[#{attribute}(1i)]"
    select I18n.t('date.month_names')[month.to_i], from: "course_class[#{attribute}(2i)]"
    select day,   from: "course_class[#{attribute}(3i)]"
    select hour,  from: "course_class[#{attribute}(4i)]"
    select min,   from: "course_class[#{attribute}(5i)]"
  end

  def sign_in_as_admin
    @admin = FactoryBot.create(:admin)
    sign_in @admin
  end
end
