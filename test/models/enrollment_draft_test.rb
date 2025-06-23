require 'test_helper'

class EnrollmentDraftTest < ActiveSupport::TestCase
  context 'associations' do
    should belong_to(:client)
    should belong_to(:course_class)
  end

  test 'should the enrollment information be a json' do
    enrollment_draft = FactoryBot.create(:enrollment_draft, :confirmation_step)

    assert_kind_of Hash, enrollment_draft.client_data
    assert_kind_of Hash, enrollment_draft.enrollment_data
    assert_kind_of Hash, enrollment_draft.payment_data
  end
end
