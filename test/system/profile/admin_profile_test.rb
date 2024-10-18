require 'application_system_test_case'

class AdminProfileTest < ApplicationSystemTestCase
  setup do
    @admin = FactoryBot.create(:admin)
    sign_in @admin
  end

  test 'admin can view profile' do
    visit admin_edit_profile_path

    assert_selector "img[src*='/assets/default-avatar.png']"
    assert_selector 'h3', text: @admin.name
    assert_selector 'h2', text: I18n.t('profile.edit_profile')
  end

  test 'admin can view page information' do
    visit admin_edit_profile_path

    assert_selector 'a', text: I18n.t('profile.edit_profile')
    assert_selector 'a', text: I18n.t('profile.edit_password')

    assert_selector 'p', text: I18n.t('profile.edit_profile_description')
  end

  test 'admin can view basic profile information' do
    visit admin_edit_profile_path

    within('form[id^="update_data_edit_admin_"]') do
      assert_field :update_data_admin_name
      assert_field :update_data_admin_email
      assert_field :update_data_admin_current_password
    end
  end

  test 'admin can update basic profile information' do
    visit admin_edit_profile_path

    within('form[id^="update_data_edit_admin_"]') do
      fill_in :update_data_admin_name, with: 'New name'
      fill_in :update_data_admin_email, with: 'newemail@example.com'
      fill_in :update_data_admin_current_password, with: @admin.password

      click_on I18n.t('buttons.save')
    end

    within('div#form-box') do
      assert_alert I18n.t('flash_messages.profile_updated')
    end

    within('form[id^="update_data_edit_admin_"]') do
      assert_field :update_data_admin_name, with: 'New name'
      assert_field :update_data_admin_email, with: 'newemail@example.com'
    end
  end

  test 'admin can update avatar' do
    visit admin_edit_profile_path

    within('form[id^="edit_admin_"]') do
      click_on 'Edit'

      assert_selector 'button[data-avatar-preview-target="check"]', visible: true

      find('label[for="admin_avatar_upload').click

      assert_selector 'input[type="file"]', visible: false

      attach_file :admin_avatar_upload, avatar_path, make_visible: true

      click_on 'Save'
    end

    assert_alert I18n.t('flash_messages.avatar_updated')
  end

  test 'admin can delete avatar' do
    visit admin_edit_profile_path

    within('form[id^="edit_admin_"]') do
      click_on 'Edit'

      assert_selector 'a[data-avatar-preview-target="trash"]', visible: false

      find('a[data-avatar-preview-target="trash"]').click
    end

    assert_alert I18n.t('flash_messages.avatar_deleted')
  end

  test 'admin can update password' do
    visit admin_edit_profile_path

    click_on I18n.t('profile.edit_password')

    assert_current_path admin_edit_password_path

    within('form[id^="update_password_edit_admin_"]') do
      fill_in :update_password_admin_current_password, with: @admin.password
      fill_in :update_password_admin_password, with: 'newpassword'
      fill_in :update_password_admin_password_confirmation, with: 'newpassword'

      click_on I18n.t('buttons.change_password')
    end

    within('div#form-box') do
      assert_alert I18n.t('flash_messages.password_updated')
    end
  end

  private

  def avatar_path
    Rails.root.join('test/factories/files/avatar.png')
  end
end
