require 'test_helper'

class EnrollmentDraftTest < ActiveSupport::TestCase
  test 'should client be a json' do
    enrollment_draft = FactoryBot.create(:enrollment_draft, :enrollment_step)

    assert_kind_of Hash, enrollment_draft.client
  end
end
