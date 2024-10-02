require 'application_system_test_case'

class AdminProfileTest < ApplicationSystemTestCase
  # setup do
  #   @admin = FactoryBot.create(:admin)
  #   sign_in @admin
  # end

  # test 'should display the edit profile page correctly' do
  #   visit edit_admin_profile_path(@admin)

  #   assert_selector 'h1', text: t('profile.edit_title')
  #   assert_text t('profile.edit_description')

  #   within('div', text: t('profile.edit_profile')) do
  #     assert_text t('profile.edit_profile_description')
  #     assert_selector "input[name='user[name]']"
  #     assert_selector "input[name='user[email]']"
  #   end

  #   assert_selector "input[type='file']"

  #   within('div', text: t('profile.edit_password')) do
  #     assert_text t('profile.edit_password_description')
  #     assert_selector "input[name='user[current_password]']"
  #     assert_selector "input[name='user[password]']"
  #     assert_selector "input[name='user[password_confirmation]']"
  #   end
  # end

  # test 'should allow the admin to update personal information' do
  #   visit edit_admin_profile_path(@admin)

  #   fill_in :admin_name, with: 'Novo Nome'
  #   fill_in :admin_email, with: 'novoemail@example.com'
  #   click_button t('buttons.save')

  #   assert_text t('flash_messages.profile_updated')
  #   @admin.reload
  #   assert_equal 'Novo Nome', @admin.name
  #   assert_equal 'novoemail@example.com', @admin.email
  # end

  # test 'should allow the admin to change the password' do
  #   visit edit_admin_profile_path(@admin)

  #   fill_in t('activerecord.attributes.admin.current_password'), with: 'senha_antiga'
  #   fill_in t('activerecord.attributes.admin.new_password'), with: 'nova_senha'
  #   fill_in t('activerecord.attributes.admin.new_password_confirmation'), with: 'nova_senha'
  #   click_button t('buttons.change_password')

  #   assert_text t('flash_messages.profile_updated')
  # end
end
