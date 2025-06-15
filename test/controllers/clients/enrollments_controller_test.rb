require 'test_helper'

class Clients::EnrollmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course = FactoryBot.create(:course)
    @course_class = FactoryBot.create(:course_class, course: @course, subscription_status: :open)
    @client = FactoryBot.create(:client)

    sign_in @client
  end

  test 'should get index with enrollments' do
    enrollment = FactoryBot.create(:enrollment, client: @client, course_class: @course_class)
    get clients_enrollments_path

    assert_response :success
    assert_includes response.body, enrollment.course_class.name
  end

  test 'should get new enrollment form' do
    get clients_new_enrollment_path(@course_class)

    assert_response :success
    assert_select 'form'
  end

  test 'should redirect if already enrolled' do
    FactoryBot.create(:enrollment, client: @client, course_class: @course_class)

    get clients_new_enrollment_path(@course_class)

    assert_redirected_to clients_enrollments_path
    assert_equal flash[:notice], I18n.t('errors.messages.already_enrolled')
  end

  test 'should advance to next step on valid submission' do
    get clients_new_enrollment_path(@course_class)

    post clients_create_enrollment_path(@course_class), params: {
      'client' => @client.attributes
    }

    assert_redirected_to clients_new_enrollment_path
    assert_predicate session["enrollment_form_#{@course_class.id}"], :present?
  end

  # test 'should create enrollment on final step' do
  #   enrollment = FactoryBot.build(:enrollment, client: @client, course_class: @course_class)

  #   get clients_new_enrollment_path(@course_class)

  #   session["enrollment_form_#{@course_class.id}"] = {
  #     current_step: :payment,
  #     client_data: @client.attributes.slice('name', 'email', 'cpf', 'phone', 'address', 'city', 'state', 'cep'),
  #     enrollment_data: enrollment.attributes.slice('category', 'terms_accepted', 'referral_source'),
  #     payment_data: {}
  #   }

  #   assert_difference('Enrollment.count', 1) do
  #     post clients_create_enrollment_path(@course_class), params: {
  #       'payment' => { 'payment_method' => 'credit_card' }
  #     }
  #   end

  #   assert_redirected_to clients_enrollments_confirmation_path
  #   assert_equal flash[:notice], I18n.t('flash_messages.created', model: Enrollment.model_name.human)
  # end

  test 'should handle invalid submission' do
    invalid_params = {
      'client' => { 'name' => '' }
    }

    post clients_create_enrollment_path(@course_class), params: invalid_params

    assert_response :unprocessable_entity
    assert_select 'p.text-red-600', text: I18n.t('errors.messages.blank',
                                                 attribute: Client.human_attribute_name(:name))
  end

  # test 'should go back to previous step' do
  #   get clients_new_enrollment_path(@course_class)

  #   get clients_previous_enrollment_path(@course_class)

  #   assert_redirected_to clients_new_enrollment_path
  #   assert_equal 'client', session["enrollment_form_#{course_class.id}"]['current_step']
  # end
end
