require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  setup do
    @client = Client.new(email: 'new_client@example.com', password: 'password')
  end

  context 'validations' do
    should validate_presence_of(:email)
    should validate_presence_of(:password)
  end

  context 'validations on update' do
    should validate_presence_of(:email).on(:update)
    should validate_presence_of(:cpf).on(:update)
    should validate_uniqueness_of(:cpf).on(:update)
    should validate_presence_of(:phone).on(:update)
    should validate_presence_of(:cep).on(:update)
    should validate_presence_of(:city).on(:update)
    should validate_presence_of(:state).on(:update)
    should validate_presence_of(:address).on(:update)
  end

  test 'client active attribute defaults to true' do
    assert @client.active
  end

  test 'validates CPF format' do
    client = FactoryBot.create(:client)
    client.update(cpf: '111.111.111-11')

    assert_not client.valid?
    assert_includes client.errors[:cpf], I18n.t('errors.messages.cpf')
  end

  test 'validates phone format' do
    client = FactoryBot.create(:client)
    client.update(phone: '123456789')

    assert_not client.valid?
    assert_includes client.errors[:phone],
                    I18n.t('errors.messages.phone', attribute: Client.human_attribute_name(:phone))
  end
end
