require 'test_helper'

class MajorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save major without title" do
    major = Major.new
    assert_not major.save, "Saved the new major without a title."
  end

  test "should save major with title" do
    major = Major.new(title: "Philosophy")
    assert major.save
  end
end
