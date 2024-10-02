require 'test_helper'

class Admin::ProfileControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = FactoryBot.create(:admin)
    sign_in @admin
  end

  test 'should get edit' do
    get edit_admin_profile_path(@admin.id)

    assert_response :success
  end

  test 'should update profile with valid parameters' do
    patch admin_profile_path(@admin.id), params: { admin: { current_password: 'password', name: 'New Name' } }

    assert_redirected_to admin_profile_path
    assert_equal t('flash_messages.profile_updated'), flash[:notice]
    @admin.reload

    assert_equal 'New Name', @admin.name
  end

  test 'should not update profile with invalid parameters' do
    patch admin_profile_path(@admin.id), params: { admin: { current_password: 'wrong_password', name: 'New Name' } }

    assert_response :unprocessable_entity
  end

  test 'should delete avatar' do
    delete delete_avatar_admin_profile_path(@admin.id)

    assert_redirected_to edit_admin_profile_path
    assert_equal t('flash_messages.avatar_deleted'), flash[:notice]
    @admin.reload

    assert_not @admin.avatar.attached?
  end
end