require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  setup do
    @admin = Admin.new(email: 'new_admin@example.com', password: 'password')
  end

  context 'validations' do
    should validate_presence_of(:email)
    should validate_presence_of(:password)
  end

  test 'admin master attribute defaults to false' do
    assert_not @admin.master
  end

  test 'admin active attribute defaults to true' do
    assert @admin.active
  end
end
