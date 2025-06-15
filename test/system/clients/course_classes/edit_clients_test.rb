require 'application_system_test_case'

class Clients::EditClientsTest < ApplicationSystemTestCase
  setup do
    @client = FactoryBot.create(:client)
    @course_class = FactoryBot.create(:course_class)
    sign_in @client
  end

  test 'visiting the edit page' do
    visit clients_new_enrollment_path(@course_class)

    assert_selector 'h1', text: I18n.t('steps.enrollment_form')
    assert_field 'client[name]', with: @client.name
    assert_field 'client[cpf]', with: @client.cpf
  end

  test 'updating client information' do
    visit clients_new_enrollment_path(@course_class)

    fill_in 'client[name]', with: 'Jane Doe'
    fill_in 'client[cpf]', with: '323.733.119-84'
    fill_in 'client[phone]', with: '(11) 98888-8888'
    click_on I18n.t('buttons.confirm')

    assert_current_path clients_new_enrollment_path(@course_class)
  end

  test 'showing errors when submitting invalid data' do
    visit clients_new_enrollment_path(@course_class)

    fill_in 'client[name]', with: ''
    fill_in 'client[cpf]', with: '123'
    fill_in 'client[phone]', with: '429842'
    click_on I18n.t('buttons.confirm')

    assert_text I18n.t('errors.messages.cpf')
    assert_text I18n.t('errors.messages.blank', attribute: Client.human_attribute_name(:name))
    assert_text I18n.t('errors.messages.phone', attribute: Client.human_attribute_name(:phone))
  end

  test 'canceling the client enrollment' do
    visit clients_new_enrollment_path(@course_class)
    click_on I18n.t('buttons.cancel')

    assert_current_path course_class_path(@course_class)
  end

  test 'checking email field disabled' do
    visit clients_new_enrollment_path(@course_class)
    email_field = find_by_id('client_email')

    assert_predicate email_field, :disabled?
  end

  test 'checking cpf mask' do
    visit clients_new_enrollment_path(@course_class)
    cpf_field = find_field('client[cpf]')

    cpf_field.fill_in with: '12345678909'

    assert_equal '123.456.789-09', cpf_field.value
  end

  test 'checking phone mask' do
    visit clients_new_enrollment_path(@course_class)
    phone_field = find_field('client[phone]')

    phone_field.fill_in with: '11999999999'

    assert_equal '(11) 99999-9999', phone_field.value
  end
end
