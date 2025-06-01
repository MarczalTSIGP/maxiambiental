require 'test_helper'

class Clients::CourseClasses::EnrollmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client = FactoryBot.create(:client)
    @course_class = FactoryBot.create(:course_class)
    sign_in @client
  end

  # INDEX
  test 'should get index' do
    get clients_enrollments_path

    assert_response :success
  end

  # NEW
  test 'should get new' do
    get clients_new_enrollment_path(@course_class)

    assert_response :success
  end

  test 'should redirects if already enrolled' do
    FactoryBot.create(:enrollment, client: @client, course_class: @course_class)
    get clients_new_enrollment_path(@course_class)

    assert_redirected_to clients_enrollments_path
    assert_equal flash[:notice], t('errors.messages.already_enrolled')
  end

  # CREATE
  test 'should create enrollment' do
    assert_difference('Enrollment.count') do
      post clients_create_enrollment_path(@course_class), params: {
        enrollment: {
          referral_source: Enrollment.referral_sources.keys.sample,
          category: Enrollment.categories.keys.sample,
          notes: 'Test notes',
          terms_accepted: '1',
          previous_participation: '0'
        }
      }
    end

    assert_redirected_to clients_new_payment_path(@course_class, Enrollment.last)
  end

  test 'should not create duplicate enrollment' do
    FactoryBot.create(:enrollment, client: @client, course_class: @course_class)

    assert_no_difference('Enrollment.count') do
      post clients_create_enrollment_path(@course_class), params: {
        enrollment: {
          referral_source: Enrollment.referral_sources.keys.sample,
          category: Enrollment.categories.keys.sample,
          terms_accepted: '1'
        }
      }
    end

    assert_response :unprocessable_entity
  end

  test 'should not create when invalid params' do
    assert_no_difference('Enrollment.count') do
      post clients_create_enrollment_path(@course_class), params: {
        enrollment: {
          terms_accepted: '0'
        }
      }
    end

    assert_response :unprocessable_entity
  end

  private

  def t(key)
    I18n.t(key)
  end
end
