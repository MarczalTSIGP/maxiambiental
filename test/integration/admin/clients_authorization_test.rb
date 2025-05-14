require 'test_helper'

class Admin::ClientsAuthorizationTest < ActionDispatch::IntegrationTest
  test 'should redirect from index when authenticated as client' do
    sign_in_as :client
    get admin_clients_path

    assert_unauthenticated_redirect
  end

  test 'should redirect from new client form when authenticated as client' do
    sign_in_as :client
    get new_admin_client_path

    assert_unauthenticated_redirect
  end

  test 'should prevent client creation when authenticated as client' do
    sign_in_as :client

    post admin_clients_path, params: { client: valid_client_params }

    assert_unauthenticated_redirect
  end

  test 'should redirect from edit client when authenticated as client' do
    sign_in_as :client

    client = FactoryBot.create(:client)

    get edit_admin_client_path(client)

    assert_unauthenticated_redirect
  end

  test 'should prevent client update when authenticated as client' do
    sign_in_as :client

    client = FactoryBot.create(:client)

    patch admin_client_path(client), params: { client: valid_client_params }

    assert_unauthenticated_redirect
  end

  test 'should prevent client deletion when authenticated as client' do
    sign_in_as :client

    client = FactoryBot.create(:client)

    delete admin_client_path(client)

    assert_unauthenticated_redirect
  end

  private

  def sign_in_as(profile)
    user = create(profile)
    sign_in user
  end

  def valid_client_params
    { name: 'New Client', email: 'new@client.com' }
  end

  def assert_unauthenticated_redirect
    assert_response :redirect
    assert_equal I18n.t('devise.failure.unauthenticated'), flash[:alert]
  end
end
