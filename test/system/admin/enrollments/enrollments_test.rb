require 'application_system_test_case'

class Admin::EnrollmentsTest < ApplicationSystemTestCase
  setup do
    @enrollment = FactoryBot.create_list(:enrollment, 2)

    sign_in FactoryBot.create(:admin)
  end

  test 'visiting the enrollments index' do
    visit admin_enrollments_path

    assert_selector 'table tbody tr', count: 2
    assert_selector 'h1', text: I18n.t('activerecord.models.enrollment', count: 2)
  end

  test 'displaying the enrollments in a table' do
    visit admin_enrollments_path

    within 'table tbody tr:nth-child(2)' do
      assert_text @enrollment.first.course_class.name
      assert_text @enrollment.first.client.name
      assert_text l(@enrollment.first.created_at, format: :short)
    end
  end

  test 'searching enrollments by client name' do
    visit admin_enrollments_path

    fill_in 'search[term]', with: @enrollment.second.client.name
    click_on 'search-button'

    assert_selector 'table tbody tr', count: 1

    within 'table tbody tr:nth-child(1)' do
      assert_text @enrollment.second.client.name
    end
  end

  test 'visiting the enrollment show page' do
    visit admin_enrollment_path(@enrollment.first)

    assert_selector 'h1', text: I18n.t('activerecord.models.enrollment', count: 1)

    within '#client-info' do
      assert_text @enrollment.first.client.name
      assert_text @enrollment.first.client.email
    end
  end

  test 'showing the course class info' do
    visit admin_enrollment_path(@enrollment.first)

    within '#course-class-info' do
      assert_text @enrollment.first.course_class.name
      assert_text @enrollment.first.course_class.schedule
    end
  end

  test 'showing the enrollment info' do
    visit admin_enrollment_path(@enrollment.first)

    within '#enrollment-info' do
      assert_text @enrollment.first.human_enum(:category)
      assert_text @enrollment.first.human_enum(:referral_source)
    end
  end

  test 'showing the payment info' do
    visit admin_enrollment_path(@enrollment.first)

    within '#payment-info' do
      assert_text l(@enrollment.first.payment.created_at, format: :short)
      assert_text @enrollment.first.payment.human_status
    end
  end
end
