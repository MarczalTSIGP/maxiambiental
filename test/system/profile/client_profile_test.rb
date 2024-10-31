require 'application_system_test_case'

class ClientProfileTest < ApplicationSystemTestCase
  setup do
    @client = FactoryBot.create(:client)
    sign_in @client
  end

  test 'client can view profile' do
    visit clients_edit_profile_path

    avatar_path = ActionController::Base.helpers.asset_path('default-avatar.png')

    assert_selector "img[src*='#{avatar_path}']"
    assert_selector 'h3', text: @client.name
    assert_selector 'h2', text: I18n.t('profile.edit_profile')
  end

  test 'client can view page information' do
    visit clients_edit_profile_path

    assert_selector 'a', text: I18n.t('profile.edit_profile')
    assert_selector 'a', text: I18n.t('profile.edit_password')

    assert_selector 'p', text: I18n.t('profile.edit_profile_description')
  end

  test 'client can view basic profile information' do
    visit clients_edit_profile_path

    within('form[id^="update_data_edit_client_"]') do
      assert_field :update_data_client_name
      assert_field :update_data_client_email
      assert_field :update_data_client_current_password
    end
  end

  test 'client can update basic profile information' do
    visit clients_edit_profile_path

    within('form[id^="update_data_edit_client_"]') do
      fill_in :update_data_client_name, with: 'New name'
      fill_in :update_data_client_email, with: 'newemail@example.com'
      fill_in :update_data_client_current_password, with: @client.password

      click_on I18n.t('buttons.save')
    end

    within('div#form-box') do
      assert_alert I18n.t('flash_messages.profile_updated')
    end
  end

  test 'client can update avatar' do
    visit clients_edit_profile_path

    within('form[id^="edit_client_"]') do
      click_on 'Edit'

      assert_selector 'button[data-avatar-preview-target="check"]', visible: true

      find('label[for="client_avatar_upload').click

      assert_selector 'input[type="file"]', visible: false

      attach_file :client_avatar_upload, avatar_path, make_visible: true

      click_on 'Save'
    end
  end

  test 'client can delete avatar' do
    visit clients_edit_profile_path

    within('form[id^="edit_client_"]') do
      click_on 'Edit'

      assert_selector 'a[data-avatar-preview-target="trash"]', visible: false

      find('a[data-avatar-preview-target="trash"]').click
    end
  end

  test 'client can update password' do
    visit clients_edit_profile_path

    click_on I18n.t('profile.edit_password')

    assert_current_path clients_edit_password_path

    within('form[id^="update_password_edit_client_"]') do
      fill_in :update_password_client_current_password, with: @client.password
      fill_in :update_password_client_password, with: 'newpassword'
      fill_in :update_password_client_password_confirmation, with: 'newpassword'

      click_on I18n.t('buttons.change_password')
    end

    assert_alert I18n.t('flash_messages.password_updated')
  end

  private

  def avatar_path
    Rails.root.join('test/factories/files/avatar.png')
  end
end
