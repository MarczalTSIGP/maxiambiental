require 'application_system_test_case'

class AdminProfileTest < ApplicationSystemTestCase
  setup do
    @admin = FactoryBot.create(:admin)
    sign_in @admin
  end

  test 'Admin can update profile' do
    visit admin_edit_profile_path

    within('form[id^="update_data_edit_admin_"]') do
      fill_in :update_data_admin_name, with: 'New name'
      fill_in :update_data_admin_email, with: 'newemail@example.com'
      fill_in :update_data_admin_current_password, with: @admin.password

      click_on I18n.t('buttons.save')
    end

    assert_alert I18n.t('flash_messages.profile_updated')

    within('form[id^="update_data_edit_admin_"]') do
      assert_field :update_data_admin_name, with: 'New name'
      assert_field :update_data_admin_email, with: 'newemail@example.com'
    end
  end
end
