require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save course without title" do
    course = Course.new
    assert_not course.save
  end

  test "should not save course without at least one associated requirement area" do
    course = Course.new(title: "Calculus 1")
    assert_not course.save
  end

  test "should not add same requirement area to same course" do
    course = Course.new(title: "A course with a unique title123")

    course.requirements << requirements(:comp_sci_maths)
    course.requirements << requirements(:comp_sci_maths)

    assert_not course.save
  end
end
