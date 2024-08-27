require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  def setup
    @admin = Admin.new(
      email: "admin@example.com",
      password: "password",
      name: "Admin Name",
      master: true,
      bio: "This is a bio.",
      avatar: "avatar_url",
      active: true
    )
  end

  test "should be valid" do
    assert @admin.valid?
  end

  test "email should be present" do
    @admin.email = "  "
    assert_not @admin.valid?
  end

  test "email should be unique" do
    duplicate_admin = @admin.dup
    @admin.save
    assert_not duplicate_admin.valid?
  end

  test "password should be present" do
    @admin.password = "  "
    assert_not @admin.valid?
  end

  test "master should default to false" do
    new_admin = Admin.new(email: "new_admin@example.com", password: "password")
    assert_not new_admin.master
  end

  test "active should default to true" do
    new_admin = Admin.new(email: "new_admin@example.com", password: "password")
    assert new_admin.active
  end
end
