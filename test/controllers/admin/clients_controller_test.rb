require 'test_helper'

class Admin::ClientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = FactoryBot.create(:admin)
    sign_in @admin
  end

  context 'GET #index' do
    should 'return success' do
      get admin_clients_path

      assert_response :success
    end

    should 'list all clients' do
      clients = FactoryBot.create_list(:client, 3)
      get admin_clients_path

      clients.each { |client| assert_includes response.body, client.name }
    end
  end

  context 'GET #new' do
    should 'return success' do
      get new_admin_client_path

      assert_response :success
    end
  end

  context 'GET #edit' do
    should 'return success' do
      get edit_admin_client_path(FactoryBot.create(:client))

      assert_response :success
    end
  end

  context 'POST #create' do
    should 'create clients with valid parameters' do
      assert_difference('Client.count') do
        post admin_clients_path, params: { client: valid_client_params }
      end

      assert_redirected_to admin_clients_path
      assert_flash('created')
      assert_not_nil Client.last.encrypted_password
    end

    should 'not create client with invalid parameters' do
      assert_no_difference('Client.count') do
        post admin_clients_path, params: { client: invalid_client_params }
      end
      assert_response :unprocessable_entity
    end
  end

  context 'PATCH #update' do
    should 'update client with valid parameters' do
      client = FactoryBot.create(:client)
      patch admin_client_path(client), params: { client: { name: 'Updated Name' } }

      assert_redirected_to admin_clients_path
      assert_flash('updated')
      assert_equal 'Updated Name', client.reload.name
    end

    should 'not update client with invalid parameters' do
      client = FactoryBot.create(:client)
      original_name = client.name

      patch admin_client_path(client), params: { client: { name: '' } }

      assert_response :unprocessable_entity
      assert_equal original_name, client.reload.name
    end
  end

  context 'DELETE #destroy' do
    should 'destroy client' do
      client = FactoryBot.create(:client)
      assert_difference('Client.count', -1) { delete admin_client_path(client) }

      assert_redirected_to admin_clients_path
      assert_flash('destroyed')
    end
  end

  private

  def valid_client_params
    { name: 'New Client', email: 'new@client.com', active: true }
  end

  def invalid_client_params
    { name: '', email: '' }
  end

  def assert_flash(action)
    assert_equal flash[:notice], I18n.t("flash_messages.#{action}", model: Client.model_name.human)
  end
end
