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
  end

  context 'validations' do
    should validate_acceptance_of(:terms_accepted)
    # should validate_inclusion_of(:category).in_array(Enrollment.categories.values)
    # should validate_inclusion_of(:referral_source).in_array(Enrollment.referral_sources.values)
  end

  should 'the course class subscription status be open' do
    enrollment = FactoryBot.build(:enrollment)

    assert_not enrollment.valid?
    assert_includes enrollment.errors[:course_class],
                    I18n.t('errors.messages.must_be_in_progress', attribute: CourseClass.model_name.human)
  end
end
