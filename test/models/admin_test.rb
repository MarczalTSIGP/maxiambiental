require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  def setup
    @admin = build(:admin)
  end

  test 'should be valid' do
    assert_predicate @admin, :valid?
  end

  test 'master should default to false' do
    new_admin = Admin.new(email: 'new_admin@example.com', password: 'password')

    assert_not new_admin.master
  end

  test 'active should default to true' do
    new_admin = Admin.new(email: 'new_admin@example.com', password: 'password')

    assert new_admin.active
  end

  context 'validations' do
    should validate_presence_of(:email)
    should validate_presence_of(:password)
  end
end
