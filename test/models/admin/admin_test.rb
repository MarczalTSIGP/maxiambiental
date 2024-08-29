require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  def setup
    @admin = Admin.new(
      email: 'admin@example.com',
      password: 'password',
      name: 'Admin Name',
      master: true,
      bio: 'This is a bio.',
      avatar: 'avatar_url',
      active: true
    )

    @auth = {
      uid: '123456789',
      email: 'user@example.com'
    }
  end

  test 'should be valid' do
    assert_predicate @admin, :valid?
  end

  test 'email should be present' do
    @admin.email = '  '

    assert_not @admin.valid?
  end

  test 'email should be unique' do
    duplicate_admin = @admin.dup
    @admin.save

    assert_not duplicate_admin.valid?
  end

  test 'password should be present' do
    @admin.password = '  '

    assert_not @admin.valid?
  end

  test 'master should default to false' do
    new_admin = Admin.new(email: 'new_admin@example.com', password: 'password')

    assert_not new_admin.master
  end

  # TODO: Check where putting these tests.
  # Tests google auth

  test 'active should default to true' do
    new_admin = Admin.new(email: 'new_admin@example.com', password: 'password')

    assert new_admin.active
  end

  test "should create a new admin if it doesn't exist" do
    assert_difference 'Admin.count', 1 do
      Admin.from_google(@auth)
    end
  end

  test "should not create a new admin if it already exists" do
    Admin.create!(email: 'user@example.com', uid: '123456789', provider: 'google', password: 'password')
    assert_no_difference 'Admin.count' do
      Admin.from_google(@auth)
    end
  end

  test "should generate a random password" do
    admin = Admin.from_google(@auth)
    assert_not_nil admin.password
  end
end
