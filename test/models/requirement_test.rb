require 'test_helper'

class RequirementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save requirement without major" do
    requirement = Requirement.new(name: "Mathematics", num_required: 3)
    assert_not requirement.save
  end

  test "should not save requirement without name" do
    requirement = Requirement.new(major: majors(:computer_science), num_required: 3)
    assert_not requirement.save
  end

  test "should save requirement with name, major, and num_required" do
    requirement = Requirement.new(name: "Mathematics", major: majors(:computer_science), num_required: 3)
    assert requirement.save
  end

  test "should not save requirement with negative num_required" do
    requirement = Requirement.new(name: "Mathematics", major: majors(:computer_science), num_required: -5)
    assert_not requirement.save
  end

  test "should not save requirement with num_required of 0" do
    requirement = Requirement.new(name: "Mathematics", major: majors(:computer_science), num_required: 0)
    assert_not requirement.save
  end

  test "should not save requirement with decimal num_required" do
    requirement = Requirement.new(name: "Mathematics", major: majors(:computer_science), num_required: 3.5)
    assert_not requirement.save
  end
end
