require "application_system_test_case"

class InstructorsNewTest < ApplicationSystemTestCase
  setup do
    @admin = FactoryBot.create(:admin)
    sign_in @admin
  end

  test "visiting the new instructor form" do
    visit new_admin_instructor_path

    assert_selector "h1", text: I18n.t('instructor.new')
    assert_text I18n.t('instructor.new_description')

    within 'form' do
      assert_selector "input[name='instructor[email]']"
      assert_selector "input[name='instructor[name]']"
      assert_selector "input[name='instructor[phone]']"
      assert_selector "trix-editor[input='instructor_resume_trix_input_instructor']"
      assert_button I18n.t('buttons.create')
    end
  end

  test "creating a new instructor" do
    visit new_admin_instructor_path

    fill_in "instructor[email]", with: "jane.smith@example.com"
    fill_in "instructor[name]", with: "Jane Smith"
    fill_in "instructor[phone]", with: "(42) 98765-4321"
    find("trix-editor").set("Experienced instructor in software development.")

    click_on I18n.t('buttons.create')

    assert_current_path admin_instructors_path
    assert_alert I18n.t('flash_messages.created', model: Instructor.model_name.human)
  end

  test "creating an instructor with invalid email" do
    visit new_admin_instructor_path

    fill_in "instructor[email]", with: "jane.smith@com"
    fill_in "instructor[name]", with: "Jane Smith"
    fill_in "instructor[phone]", with: "(42) 98765-4321"
    find("trix-editor").set("Experienced instructor in software development.")

    click_on I18n.t('buttons.create')

    assert_current_path new_admin_instructor_path
    assert_validation_error I18n.t('errors.messages.invalid', attribute: 'E-mail')
  end
end
