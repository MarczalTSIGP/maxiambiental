require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  setup do
    course_class = FactoryBot.create(:course_class, subscription_status: :open)
    enrollment = FactoryBot.create(:enrollment, course_class: course_class)
    @payment = FactoryBot.build(:payment, enrollment: enrollment)
  end

  context 'associations' do
    should belong_to(:client)
    should belong_to(:enrollment)
  end

  context 'validations' do
    should validate_presence_of(:payment_method)
  end

  should 'confirm the payment after creation' do
    assert_predicate @payment, :pending?
    assert @payment.save
    assert_predicate @payment, :confirmed?
  end
end
