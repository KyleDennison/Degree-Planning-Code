require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save user without email" do
    user = User.new(firstname: "John", lastname: "Doe")
    assert_not user.save, "Saved user without an email"
  end

  test "should not save user without first and last name" do
    user = User.new(email: "faculty@ncf.edu")
    assert_not user.save, "Saved user without first and last name"
  end

  test "user with required fields should save" do
    user = User.new(email: "faculty@ncf.edu", firstname: "Jane", lastname: "Smith", password: "password")
    assert user.save, "Didn't save valid user"
  end

  test "email should be unique" do
    user = User.new(firstname: "Jane", lastname: "Smith", password: "password")
    user.email = users(:jane_smith).email

    assert_not user.save
  end
end
