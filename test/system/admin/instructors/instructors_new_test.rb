require 'application_system_test_case'

class InstructorsNewTest < ApplicationSystemTestCase
  setup do
    @admin = FactoryBot.create(:admin)
    sign_in @admin
  end

  test 'displays the new instructor form' do
    visit new_admin_instructor_path

    within 'form' do
      assert_selector(
        "input[name='instructor[email]'], input[name='instructor[name]'], input[name='instructor[phone]']",
        count: 3
      )

      assert_selector "trix-editor[input='instructor_resume_trix_input_instructor']"
      click_on I18n.t('helpers.submit.create', model: Instructor.model_name.human)
    end
  end

  test 'successfully creates a new instructor' do
    visit new_admin_instructor_path

    fill_in 'instructor[email]', with: 'jane.smith@example.com'
    fill_in 'instructor[name]', with: 'Jane Smith'
    fill_in 'instructor[phone]', with: '(42) 98765-4321'
    find('trix-editor').set('Experienced instructor in software development.')

    click_on I18n.t('helpers.submit.create', model: Instructor.model_name.human)

    assert_current_path admin_instructors_path
    assert_alert I18n.t('flash_messages.created', model: Instructor.model_name.human)
  end

  test 'shows validation error for invalid email' do
    visit new_admin_instructor_path

    fill_in 'instructor[email]', with: 'jane.smith@com'
    fill_in 'instructor[name]', with: 'Jane Smith'
    fill_in 'instructor[phone]', with: '(42) 98765-4321'
    find('trix-editor').set('Experienced instructor in software development.')

    click_on I18n.t('helpers.submit.create', model: Instructor.model_name.human)

    assert_current_path new_admin_instructor_path
    assert_validation_error I18n.t('errors.messages.email', attribute: 'e-mail')
  end
end
