require 'application_system_test_case'

class Clients::CourseClasses::EnrollmentsTest < ApplicationSystemTestCase
  setup do
    @client = FactoryBot.create(:client)
    @course_class = FactoryBot.create(:course_class, subscription_status: 'open')

    sign_in @client
  end

  test 'visiting the index' do
    visit clients_enrollments_path

    assert_selector 'h1', text: I18n.t('clients.course_classes.enrollments.index.title')
  end

  test 'showing the enrollments information' do
    enrollment = FactoryBot.create(:enrollment, course_class: @course_class, client: @client)

    visit clients_enrollments_path

    within '#enrollments_table' do
      within "#enrollment_#{enrollment.id}" do
        assert_text enrollment.course_class.name
        assert_text l(enrollment.created_at, format: :short)
        assert_text enrollment.human_enum(:status)
      end
    end
  end

  test 'visiting the new enrollment page' do
    visit clients_new_enrollment_path(@course_class)

    assert_selector 'h1', text: I18n.t('steps.enrollment_form')
    assert_selector '#step-2.text-green-700', text: I18n.t('steps.enrollment.course_data')
  end

  test 'creating a new enrollment' do
    visit clients_new_enrollment_path(@course_class)

    select human_enum(:referral_source, 'others'), from: 'enrollment_referral_source'
    select human_enum(:category, 'student'), from: 'enrollment_category'
    check 'enrollment_terms_accepted'
    click_on I18n.t('buttons.confirm')

    assert_selector '#step-3.text-green-700', text: I18n.t('steps.enrollment.payment')
    page.assert_current_path clients_new_payment_path(@course_class, Enrollment.last)
  end

  test 'creating a new enrollment with invalid data' do
    visit clients_new_enrollment_path(@course_class)

    select human_enum(:referral_source, 'others'), from: 'enrollment_referral_source'
    select human_enum(:category, 'student'), from: 'enrollment_category'
    click_on I18n.t('buttons.confirm')

    within '.enrollment_terms_accepted' do
      assert_text I18n.t('errors.messages.accepted', attribute: Enrollment.human_attribute_name(:terms_accepted))
    end
  end

  private

  def human_enum(enum_name, value)
    I18n.t("activerecord.attributes.enrollment.#{enum_name.to_s.pluralize}.#{value}")
  end
end
