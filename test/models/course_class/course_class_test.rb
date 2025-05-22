require 'test_helper'

class CourseClassTest < ActiveSupport::TestCase
  setup do
    @course_class = FactoryBot.create(:course_class)
  end

  context 'validations' do
    should validate_presence_of(:name)
    should validate_presence_of(:start_at)
    should validate_presence_of(:end_at)
    should validate_presence_of(:schedule)
  end

  context 'associations' do
    should belong_to(:course)
    should belong_to(:instructor)
  end

  should 'validate end_at is after start_at' do
    @course_class.end_at = @course_class.start_at - 1.hour

    assert_not @course_class.valid?

    assert_includes @course_class.errors[:end_at],
                    I18n.t('errors.messages.greater_than',
                           attribute: CourseClass.human_attribute_name(:end_at),
                           count: @course_class.start_at)
  end

  should 'active attribute default to true' do
    assert @course_class.active
  end
end
