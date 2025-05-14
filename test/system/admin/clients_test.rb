require 'application_system_test_case'

class Admin::ClientsTest < ApplicationSystemTestCase
  setup do
    @clients = FactoryBot.create_list(:client, 3)
    @admin = FactoryBot.create(:admin)
    sign_in @admin
  end

  test 'visiting the index' do
    visit admin_clients_path

    assert_selector 'h1', text: I18n.t('admin.clients.index.title')
  end

  test 'displays a table with clients' do
    visit admin_clients_path

    assert_data_table @clients
  end

  test 'should displays the correct searched instructors' do
    client = @clients.last

    visit admin_clients_path

    fill_in 'search[term]', with: client.name
    click_on 'search-button'

    assert_data_table [client]
  end

  test 'visiting the create page' do
    visit admin_clients_path

    click_on I18n.t('admin.clients.index.new')

    assert_selector 'h1', text: I18n.t('admin.clients.new.title')
  end

  test 'creating a client' do
    visit new_admin_client_path

    fill_in 'client[name]', with: 'Maria'
    fill_in 'client[email]', with: 'maria@client'
    click_on I18n.t('helpers.submit.create', model: model_name)

    assert_text I18n.t('flash_messages.created', model: model_name)
  end

  test 'attempting to create a client without required fields' do
    visit new_admin_client_path

    click_on I18n.t('helpers.submit.create', model: model_name)

    within '.client_name' do
      assert_text I18n.t('errors.messages.blank', attribute: Client.human_attribute_name(:name))
    end
  end

  test 'visiting the edit page' do
    client = @clients.first

    visit admin_clients_path

    within "#client_#{client.id}" do
      find('.fa-pen').click
    end

    assert_selector 'h1', text: I18n.t('admin.clients.edit.title')

    within 'form' do
      assert_field 'client[name]', with: client.name
      assert_field 'client[email]', with: client.email
    end
  end

  test 'updating a client' do
    visit edit_admin_client_path(@clients.first)

    fill_in 'client[name]', with: 'Maria'
    click_on I18n.t('helpers.submit.update', model: model_name)

    assert_current_path admin_clients_path
    assert_text I18n.t('flash_messages.updated', model: model_name)
  end

  test 'deleting a client' do
    visit admin_clients_path

    assert_difference('Client.count', -1) do
      accept_confirm do
        within "#client_#{@clients.first.id}" do
          find('.fa-trash').click
        end
      end

      assert_text I18n.t('flash_messages.destroyed', model: model_name)
    end
  end

  private

  def model_name
    Client.model_name.human
  end

  def assert_data_table(clients)
    assert_selector 'table tbody tr', count: clients.size

    clients.each do |client|
      within "#client_#{client.id}" do
        assert_text client.name
        assert_text client.email
      end
    end
  end
end
