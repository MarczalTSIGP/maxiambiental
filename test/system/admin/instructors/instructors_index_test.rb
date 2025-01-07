require 'application_system_test_case'

class InstructorsIndexTest < ApplicationSystemTestCase
  setup do
    @admin = FactoryBot.create(:admin)
    sign_in @admin
  end

  test 'displays the index page header and description' do
    visit admin_instructors_path

    assert_selector 'h1', text: I18n.t('instructor.title')
    assert_text I18n.t('instructor.description')
  end

  test 'displays the new instructor button' do
    visit admin_instructors_path

    assert_selector 'a', text: I18n.t('instructor.new')
  end

  test 'displays instructor information in the table' do
    @instructor = FactoryBot.create(:instructor)

    visit admin_instructors_path

    within 'table' do
      assert_text @instructor.name
      assert_text @instructor.email
      assert_text @instructor.phone
    end
  end

  test 'shows empty state when no instructors exist' do
    visit admin_instructors_path

    assert_text I18n.t('activerecord.models.instructor')
    assert_selector 'a', text: I18n.t('instructor.new')
  end
end
