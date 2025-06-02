require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  should validate_presence_of(:email)
  should validate_presence_of(:name)
  should validate_presence_of(:password).on(:create)

  test 'active attribute defaults to true' do
    assert FactoryBot.build(:client).active
  end

  test 'rejects duplicate email' do
    existing = FactoryBot.create(:client)
    new_client = FactoryBot.build(:client, email: existing.email)

    assert_not new_client.valid?
    assert_includes new_client.errors[:email], I18n.t('errors.messages.taken')
  end

  test 'validates CPF format when present' do
    client = FactoryBot.build(:client, cpf: '111.111.111-11')

    assert_not client.valid?
    assert_includes client.errors[:cpf], I18n.t('errors.messages.cpf')
  end

  test 'requires unique CPF' do
    existing = FactoryBot.create(:client)
    client = FactoryBot.build(:client, cpf: existing.cpf)

    assert_not client.valid?
    assert_includes client.errors[:cpf], I18n.t('errors.messages.taken')
  end

  test 'validates phone format when present' do
    client = FactoryBot.build(:client, phone: '123456')

    assert_not client.valid?
    assert_includes client.errors[:phone],
                    I18n.t('errors.messages.phone', attribute: Client.human_attribute_name(:phone))
  end

  test 'requires address fields when the attributes are present' do
    client = FactoryBot.build(:client, city: nil, state: nil)

    assert_not client.valid?

    assert_includes client.errors[:city], blank_message_for(:city)
    assert_includes client.errors[:state], blank_message_for(:state)
  end

  test 'validates CEP format' do
    client = FactoryBot.build(:client, cep: '123456')

    assert_not client.valid?
    assert_includes client.errors[:cep], I18n.t('errors.messages.invalid', attribute: 'CEP')
  end

  test 'set_random_password sets password when blank' do
    client = FactoryBot.build(:client, password: nil)
    client.set_random_password

    assert_predicate client.password, :present?
    assert_equal client.password, client.password_confirmation
  end

  private

  def blank_message_for(attribute)
    I18n.t('errors.messages.blank', attribute: Client.human_attribute_name(attribute))
  end
end
