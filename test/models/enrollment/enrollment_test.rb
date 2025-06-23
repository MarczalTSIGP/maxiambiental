require 'test_helper'

class EnrollmentTest < ActiveSupport::TestCase
  setup do
    @client = FactoryBot.create(:client)
    @course_class = FactoryBot.create(:course_class, subscription_status: :open)
    @enrollment = FactoryBot.build(:enrollment, client: @client, course_class: @course_class)
  end

  context 'associations' do
    should belong_to(:client)
    should belong_to(:course_class)
    should have_many(:payments).dependent(:destroy)
  end

  context 'enums' do
    should define_enum_for(:category).with_values(
      teacher: 'teacher',
      student: 'student'
    ).backed_by_column_of_type(:string)

    should define_enum_for(:status).with_values(
      pending: 'pending',
      confirmed: 'confirmed',
      finished: 'finalized',
      canceled: 'canceled'
    ).backed_by_column_of_type(:string)

    should define_enum_for(:referral_source).with_values(
      social_media: 'social_media',
      friends: 'friends',
      website: 'website',
      email: 'email',
      others: 'others'
    ).backed_by_column_of_type(:string)
  end

  context 'validations' do
    should validate_acceptance_of(:terms_accepted)

    should validate_presence_of(:category)
    should validate_presence_of(:referral_source)

    # should validate_inclusion_of(:category).in_array(Enrollment.categories.keys)
    # should validate_inclusion_of(:referral_source).in_array(Enrollment.referral_sources.keys)

    should 'validate that course class subscription must be open' do
      closed_course_class = FactoryBot.create(:course_class, subscription_status: :closed)
      enrollment = FactoryBot.build(:enrollment, client: @client, course_class: closed_course_class)

      assert_not enrollment.valid?
      assert_includes enrollment.errors[:course_class],
                      I18n.t('errors.messages.must_be_in_progress', attribute: CourseClass.model_name.human)
    end
  end

  test 'should prevent duplicate enrollments for same client and course class' do
    FactoryBot.create(:enrollment, client: @client, course_class: @course_class)
    duplicate = FactoryBot.build(:enrollment, client: @client, course_class: @course_class)

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:client_id], I18n.t('errors.messages.taken')
  end

  test 'should allow same client for different course classes' do
    another_course_class = FactoryBot.create(:course_class, subscription_status: :open)
    FactoryBot.create(:enrollment, client: @client, course_class: @course_class)
    valid_enrollment = FactoryBot.build(:enrollment, client: @client, course_class: another_course_class)

    assert_predicate valid_enrollment, :valid?
  end
end
