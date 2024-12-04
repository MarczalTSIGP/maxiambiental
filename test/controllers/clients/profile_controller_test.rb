require 'test_helper'

class Clients::ProfileControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client = FactoryBot.create(:client)
    sign_in @client
  end

  test 'should get edit profile page' do
    get clients_edit_profile_path

    assert_response :success
  end

  test 'successful update for google authenticated client' do
    @client.define_singleton_method(:google_authenticated?) do
      true
    end

    patch clients_update_profile_path(@client),
          params: { client: { name: 'Updated Name' } }

    assert_redirected_to clients_edit_profile_path
    assert_equal flash[:notice], I18n.t('flash_messages.profile_updated')

    @client.reload

    assert_equal 'Updated Name', @client.name
  end

  test 'successful update for non-google authenticated client' do
    patch clients_update_profile_path(@client),
          params: { client: { name: 'Updated Name',
                              email: @client.email,
                              current_password: 'password' } }

    assert_redirected_to clients_edit_profile_path
    assert_equal flash[:notice], I18n.t('flash_messages.profile_updated')
  end

  test 'failed update due to invalid parameters' do
    patch clients_update_profile_path(@client),
          params: { client: { email: 'client.com', name: '' } }

    assert_response :unprocessable_entity
    assert_select 'p.text-red-600', t('errors.messages.invalid', attribute: 'E-mail')
    assert_select 'p.text-red-600', t('errors.messages.blank', attribute: 'Nome')
  end

  test 'should get edit password page' do
    get clients_edit_password_path

    assert_response :success
  end

  test 'successful password update' do
    patch clients_update_password_path,
          params: { client: { current_password: @client.password,
                              password: 'new_password123',
                              password_confirmation: 'new_password123' } }

    assert_redirected_to clients_edit_password_path
    assert_equal I18n.t('flash_messages.password_updated'), flash[:notice]
  end

  test 'failed password update due to invalid current password' do
    patch clients_update_password_path,
          params: { client: { current_password: 'wrong_password',
                              password: 'new_password123',
                              password_confirmation: 'new_password123' } }

    assert_response :unprocessable_entity
    assert_select 'p.text-red-600', t('errors.messages.invalid', attribute: 'Senha atual')
  end

  test 'failed password update due to mismatched passwords' do
    patch clients_update_password_path,
          params: { client: { current_password: @client.password,
                              password: 'new_password123',
                              password_confirmation: 'different_password' } }

    assert_response :unprocessable_entity
    assert_select 'p.text-red-600', t('errors.messages.confirmation', attribute: 'Senha')
  end

  test 'successful avatar update' do
    file = fixture_file_upload('avatar.png', 'image/jpeg')

    patch clients_update_avatar_path, params: { client: { avatar: file } }

    assert_redirected_to clients_edit_profile_path

    @client.reload

    assert_predicate @client.avatar, :attached?
  end

  test 'failed avatar update' do
    file = fixture_file_upload('test.txt', 'text/plain')

    patch clients_update_avatar_path, params: { client: { avatar: file } }

    assert_redirected_to clients_edit_profile_path
  end

  test 'delete avatar' do
    @client.avatar.attach(fixture_file_upload('avatar.png', 'image/jpeg'))

    delete clients_delete_avatar_path

    assert_redirected_to clients_edit_profile_path
    assert_equal I18n.t('flash_messages.avatar_deleted'), flash[:notice]

    @client.reload

    assert_not_predicate @client.avatar, :attached?
  end
end
