require 'test_helper'

class Admin::ProfileControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = FactoryBot.create(:admin)
    sign_in @admin
  end

  test 'should get edit' do
    get admin_edit_profile_path(@admin)

    assert_response :success
  end

  test 'should update profile with valid parameters' do
    patch admin_update_profile_path(@admin), params: { admin: { current_password: 'password', name: 'New Name' } }

    assert_redirected_to admin_edit_profile_path
    assert_equal t('flash_messages.profile_updated'), flash[:notice]
    @admin.reload

    assert_equal 'New Name', @admin.name
  end

  test 'should not update profile with invalid parameters' do
    patch admin_update_profile_path(@admin.id),
          params: { admin: { current_password: 'wrong_password', name: 'New Name' } }

    assert_response :unprocessable_entity
  end

  test 'should delete avatar' do
    delete admin_delete_avatar_path(@admin)

    assert_redirected_to admin_edit_profile_path
    assert_equal t('flash_messages.avatar_deleted'), flash[:notice]
    @admin.reload

    assert_not @admin.avatar.attached?
  end

  test 'should update password with valid parameters' do
    patch admin_update_password_path(@admin),
          params: { admin: { current_password: 'password', password: 'new_password',
                             password_confirmation: 'new_password' } }

    assert_redirected_to admin_edit_password_path
    assert_equal t('flash_messages.password_updated'), flash[:notice]
    @admin.reload

    assert @admin.valid_password?('new_password')
  end

  test 'should not update password with invalid parameters' do
    patch admin_update_password_path(@admin),
          params: { admin: { current_password: 'wrong_password', password: 'new_password',
                             password_confirmation: 'new_password' } }

    assert_response :unprocessable_entity
  end
end
