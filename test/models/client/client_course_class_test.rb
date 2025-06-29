require 'test_helper'

class ClientCourseClassTest < ActiveSupport::TestCase
  setup do
    @client = FactoryBot.create(:client)
    @course_class = FactoryBot.create(:course_class, subscription_status: :open)
  end

  test 'enrolled_in? returns true when client has active enrollment' do
    FactoryBot.create(:enrollment, client: @client,
                                   course_class: @course_class)

    assert @client.enrolled_in?(@course_class)
  end

  test 'enrolled_in? returns false when enrollment is canceled' do
    enrollment = FactoryBot.create(:enrollment, client: @client,
                                                course_class: @course_class)

    enrollment.update(status: :canceled)

    assert_not @client.enrolled_in?(@course_class)
  end

  test 'enrolled_in? returns false when no enrollment exists' do
    assert_not @client.enrolled_in?(@course_class)
  end
end
