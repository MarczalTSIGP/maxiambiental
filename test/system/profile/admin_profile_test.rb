require 'application_system_test_case'

class AdminProfileTest < ApplicationSystemTestCase
  # setup do
  #   @admin = FactoryBot.create(:admin)
  #   sign_in @admin
  # end

  # test "Admin can update profile" do
  #   visit admin_edit_profile_path

  #   within(".grid") do
  #     fill_in 'admin_name', with: "New name"
  #     fill_in 'admin_email', with: "newemail@example.com"
  #     fill_in 'admin_current_password', with: @admin.password
      
  #     click_on t('buttons.save')
  #   end

  #   assert_text "Profile was successfully updated"
  #   assert_equal "New name", @admin.reload.name
  #   assert_equal "newemail@example.com", @admin.reload.email
  # end
end
