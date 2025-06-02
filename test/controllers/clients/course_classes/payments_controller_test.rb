require 'test_helper'

class Clients::CourseClasses::PaymentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client = FactoryBot.create(:client)
    @course_class = FactoryBot.create(:course_class, subscription_status: :open)
    @enrollment = FactoryBot.create(:enrollment, client: @client, course_class: @course_class)

    sign_in @client
  end

  test 'should get new' do
    get clients_new_payment_path(@course_class, @enrollment)

    assert_response :success
  end

  test 'should redirect if enrollment payment is not pending' do
    create_payment(:confirmed)

    get clients_new_payment_path(@course_class, @enrollment)

    assert_redirected_to clients_enrollments_path
  end

  test 'should create payment' do
    assert_difference('Payment.count') do
      post clients_create_payment_path(@course_class, @enrollment), params: {
        payment: {
          payment_method: 'credit_card'
        }
      }
    end

    assert_redirected_to clients_payment_confirmation_path(payment_id: Payment.last)
  end

  test 'should not create payment with invalid params' do
    assert_no_difference('Payment.count') do
      post clients_create_payment_path(@course_class, @enrollment), params: {
        payment: {
          payment_method: ''
        }
      }
    end

    assert_response :unprocessable_entity
  end

  test 'should assigns payment to correct enrollment' do
    post clients_create_payment_path(@course_class, @enrollment), params: {
      payment: {
        payment_method: 'pix'
      }
    }

    assert_equal @enrollment, Payment.last.enrollment
  end

  test 'should get confirmation' do
    create_payment(:confirmed)

    get clients_payment_confirmation_path(@course_class, @enrollment)

    assert_response :success
  end

  private

  def create_payment(status)
    FactoryBot.create(:payment, enrollment: @enrollment, client: @client, status: status)
  end
end
