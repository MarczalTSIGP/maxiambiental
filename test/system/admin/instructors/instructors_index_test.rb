require "application_system_test_case"

class InstructorsIndexTest < ApplicationSystemTestCase
  setup do
    @admin = FactoryBot.create(:admin)
    sign_in @admin
  end

  test "visiting the index page" do
    @instructor = FactoryBot.create(:instructor)

    visit admin_instructors_path

    assert_selector "h1", text: I18n.t('instructor.title')
    assert_text I18n.t('instructor.description')

    assert_selector "a", text: I18n.t('instructor.new')

    within "table" do
      assert_text @instructor.name
      assert_text @instructor.email
      assert_text @instructor.phone
      assert_selector 'a', text: I18n.t('instructor.view_resume')
      assert_selector "span.badge-active", text: "Ativo"
      assert_selector 'a', text: 'Editar'
    end
  end

  # test "deleting an instructor" do
  #   visit admin_instructors_path

  #   accept_confirm do
  #     click_on "Delete", match: :first
  #   end

  #   assert_text "Instructor was successfully destroyed"
  #   refute_text @instructor.name
  # end

  test "showing empty state when no instructors exist" do
    visit admin_instructors_path

    assert_text I18n.t('activerecord.models.instructor')
    assert_selector "a", text: I18n.t('instructor.new')
  end
end
