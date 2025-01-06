require "application_system_test_case"

class InstructorsEditTest < ApplicationSystemTestCase
  setup do
    @admin = FactoryBot.create(:admin)
    @instructor = FactoryBot.create(:instructor)
    sign_in @admin
  end

  test "visiting the edit instructor form" do
    visit edit_admin_instructor_path(@instructor)

    assert_selector "h1", text: I18n.t('instructor.edit')
    assert_text I18n.t('instructor.edit:description')

    within 'form' do
      assert_selector "input[value='#{@instructor.email}']"
      assert_selector "input[value='#{@instructor.name}']"
      assert_selector "input[value='#{@instructor.phone}']"

      within 'trix-editor' do
        assert_text @instructor.resume.to_plain_text
      end

      assert_selector "input[type='checkbox'][checked='checked']"
      assert_button I18n.t('buttons.save')
    end
  end

  test "editing an instructor" do
    visit edit_admin_instructor_path(@instructor)

    fill_in "instructor[email]", with: "test@example.com"
    fill_in "instructor[name]", with: "Updated Name"
    fill_in "instructor[phone]", with: "(99) 99999-9999"
    find("trix-editor").set("Updated resume content.")
    find("div#toggle").click

    click_on I18n.t('buttons.save')

    assert_current_path admin_instructors_path
    assert_alert I18n.t('flash_messages.updated', model: Instructor.model_name.human)
  end

  test 'editing an instructor with invalid data' do
    visit edit_admin_instructor_path(@instructor)

    fill_in "instructor[email]", with: ''

    click_on I18n.t('buttons.save')

    assert_current_path edit_admin_instructor_path(@instructor)
    assert_validation_error I18n.t('errors.messages.blank', attribute: 'E-mail')
  end
end
