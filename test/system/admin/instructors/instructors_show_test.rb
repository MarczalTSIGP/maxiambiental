require 'application_system_test_case'

class InstructorsShowTest < ApplicationSystemTestCase
  setup do
    @admin = FactoryBot.create(:admin)
    @instructor = FactoryBot.create(:instructor)

    sign_in @admin
  end

  test 'displays instructor profile section' do
    visit admin_instructor_path(@instructor)

    within 'div#profile' do
      assert_text @instructor.name
    end
  end

  test 'displays instructor contact section' do
    visit admin_instructor_path(@instructor)

    within 'div#contact' do
      assert_text @instructor.email
      assert_text @instructor.phone
    end
  end

  test 'displays instructor resume section' do
    visit admin_instructor_path(@instructor)

    within 'div#resume' do
      lines = @instructor.resume.to_plain_text.lines.map(&:strip).compact_blank

      lines.each do |line|
        assert_text line
      end
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
