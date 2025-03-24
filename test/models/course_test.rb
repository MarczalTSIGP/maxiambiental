require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  setup do
    @course = FactoryBot.create(:course)
  end

  context 'validations' do
    should validate_presence_of(:name)
    should validate_length_of(:name).is_at_least(3)

    should validate_presence_of(:description)
  end

  test 'should be valid' do
    assert_predicate @course, :valid?
  end

  test 'should not be valid' do
    @course.name = nil

    assert_not @course.valid?
  end

  test 'should be active by default' do
    assert @course.active
  end

  test 'should have an attached image' do
    assert_kind_of ActiveStorage::Attached::One, @course.image, 'Avatar should be attached'
  end
end
