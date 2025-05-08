require 'application_system_test_case'

class IndicesTest < ApplicationSystemTestCase
  setup do
    @admin = FactoryBot.create(:admin)
    sign_in @admin
  end

  test 'visiting the index' do
    visit admin_clients_path

    assert_selector 'h1', text: I18n.t('admin.clients.index.title')
  end

  test 'should display a table with clients' do
    clients = FactoryBot.create_list(:client, 3)

    visit admin_clients_path

    assert_data_table clients
  end

  test 'should display a link to create a new client' do
    visit admin_clients_path

    assert_selector 'a', text: I18n.t('admin.clients.index.new')
  end

  test 'should display a link to edit a client' do
    FactoryBot.create(:client)
    visit admin_clients_path

    assert_selector 'a i.fa-pen'
  end

  test 'should display a link to delete a client' do
    FactoryBot.create(:client)
    visit admin_clients_path

    assert_selector 'a i.fa-trash'
  end

  test 'should displays the correct searched instructors' do
    FactoryBot.create(:client, name: 'Maria')
    client_ana = FactoryBot.create(:client, name: 'Ana')

    visit admin_clients_path

    fill_in 'search[term]', with: 'Ana'
    click_on 'search-button'

    assert_data_table [client_ana]
  end

  private

  def assert_data_table(collection)
    assert_selector 'table tbody tr', count: collection.size

    collection.each do |client|
      assert_selector 'table tbody tr td', text: client.name
    end
  end
end
