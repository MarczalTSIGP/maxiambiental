require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  should validate_presence_of(:email)
  should validate_presence_of(:name)
  should validate_presence_of(:password).on(:create)

  should validate_uniqueness_of(:email).case_insensitive
  should validate_length_of(:password).is_at_least(6)

  test 'active attribute defaults to true' do
    assert FactoryBot.build(:client).active
  end
end
