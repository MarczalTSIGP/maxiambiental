require 'test_helper'

class Admin::ClientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = FactoryBot.create(:admin)
    sign_in @admin
  end

  test 'should get index' do
    get admin_clients_url

    assert_response :success
  end

  test 'should get all clients' do
    clients = FactoryBot.create_list(:client, 3)

    get admin_clients_url

    clients.each do |client|
      assert_select 'tr', text: client.name
    end
  end
end
