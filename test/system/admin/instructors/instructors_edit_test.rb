require 'application_system_test_case'

class InstructorsEditTest < ApplicationSystemTestCase
  setup do
    @admin = FactoryBot.create(:admin)
    @instructor = FactoryBot.create(:instructor)
    sign_in @admin
  end

  test 'displays the edit instructor page header' do
    visit edit_admin_instructor_path(@instructor)

    assert_selector 'h1', text: I18n.t('admin.instructors.edit.title')
    assert_text I18n.t('admin.instructors.edit.description')
  end

  test 'displays the instructor information in the form' do
    visit edit_admin_instructor_path(@instructor)

    within 'form' do
      assert_selector "input[value='#{@instructor.email}']"
      assert_selector "input[value='#{@instructor.name}']"
      assert_selector "input[value='#{@instructor.phone}']"
    end
  end

  test 'displays the instructor resume in the editor' do
    visit edit_admin_instructor_path(@instructor)

    within 'form trix-editor' do
      lines = @instructor.resume.to_plain_text.lines.map(&:strip).compact_blank

      lines.each do |line|
        assert_text line
      end
    end
  end

  test 'displays the toggle and save button' do
    visit edit_admin_instructor_path(@instructor)

    within 'form' do
      assert_selector "input[type='checkbox'][checked='checked']"
      click_on I18n.t('helpers.submit.update', model: Instructor.model_name.human)
    end
  end

  test 'successfully edits an instructor' do
    visit edit_admin_instructor_path(@instructor)

    fill_in 'instructor[email]', with: 'test@example.com'
    fill_in 'instructor[name]', with: 'Updated Name'
    fill_in 'instructor[phone]', with: '(99) 99999-9999'
    find('trix-editor').set('Updated resume content.')

    click_on I18n.t('helpers.submit.update', model: Instructor.model_name.human)

    assert_current_path admin_instructors_path
    assert_alert I18n.t('flash_messages.updated', model: Instructor.model_name.human)
  end

  test 'shows validation errors when editing with invalid data' do
    visit edit_admin_instructor_path(@instructor)

    fill_in 'instructor[email]', with: ''

    click_on I18n.t('helpers.submit.update', model: Instructor.model_name.human)

    assert_current_path edit_admin_instructor_path(@instructor)
    assert_validation_error I18n.t('errors.messages.blank', attribute: 'E-mail')
  end
end
