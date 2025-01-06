require "application_system_test_case"

class InstructorsShowTest < ApplicationSystemTestCase
  setup do
    @admin = FactoryBot.create(:admin)
    @instructor = FactoryBot.create(:instructor)

    sign_in @admin
  end

  test 'visiting the show page' do
    visit admin_instructors_path

    click_link I18n.t('instructor.view_resume')

    assert_current_path admin_instructor_path(@instructor)
    
    within 'div#profile' do
      assert_text @instructor.name
    end

    within 'div#contact' do
      assert_text @instructor.email
      assert_text @instructor.phone
    end

    within 'div#resume' do
      assert_text @instructor.resume.to_plain_text
    end
  end

  test 'admin can update the instructor avatar' do
    visit admin_instructor_path(@instructor)

    within('form[id^="edit_instructor_"]') do
      click_on 'Edit'

      assert_selector 'button[data-avatar-preview-target="check"]', visible: true

      find('label[for="avatar_upload').click

      assert_selector 'input[type="file"]', visible: false

      attach_file :avatar_upload, avatar_path, make_visible: true

      click_on 'Save'
    end
  end

  private

  def avatar_path
    Rails.root.join('test/factories/files/avatar.png')
  end
end
