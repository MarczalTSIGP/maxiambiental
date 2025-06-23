require 'application_system_test_case'

class Clients::PaymentsTest < ApplicationSystemTestCase
  setup do
    @client = FactoryBot.create(:client)
    @course_class = FactoryBot.create(:course_class, subscription_status: 'open')
    FactoryBot.create(:enrollment_draft, :payment_step, client: @client, course_class: @course_class)

    sign_in @client
  end

  test 'visiting the payment page' do
    visit clients_new_enrollment_path(@course_class)

    assert_selector 'h1', text: I18n.t('steps.enrollment_form')
    assert_selector '#step-3.text-green-700', text: I18n.t('steps.enrollment.payment')
    assert_selector '#payment_payment_method', visible: false
  end

  test 'selecting credit card as payment method' do
    visit clients_new_enrollment_path(@course_class)

    select 'Cartão de Crédito', from: 'payment_payment_method'

    assert_selector '#payment_card_number', visible: true
    assert_selector '#payment_card_expiry_date', visible: true
    assert_selector '#payment_card_cvv', visible: true
  end

  test 'selecting bank slip as payment method' do
    visit clients_new_enrollment_path(@course_class)

    select 'Boleto', from: 'payment_payment_method'

    assert_selector 'h2', text: 'Pagamento via Boleto'
  end

  test 'selecting pix as payment method' do
    visit clients_new_enrollment_path(@course_class)

    select 'Pix', from: 'payment_payment_method'

    assert_selector 'h2', text: 'Pagamento via PIX'
  end

  test 'completing payment' do
    visit clients_new_enrollment_path(@course_class)

    select 'Pix', from: 'payment_payment_method'

    click_on I18n.t('buttons.confirm')

    assert_selector '#step-4.text-green-700', text: I18n.t('steps.enrollment.confirmation')

    within '#enrollment-confirmation' do
      assert_selector 'h1', text: 'Pagamento Aprovado!'
    end
  end

  private

  def human_enum(enum_name, value)
    I18n.t("activerecord.attributes.enrollment.#{enum_name.to_s.pluralize}.#{value}")
  end
end
