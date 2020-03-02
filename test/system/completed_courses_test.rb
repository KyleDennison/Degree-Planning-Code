require "application_system_test_case"

class CompletedCoursesTest < ApplicationSystemTestCase
  setup do
    @completed_course = completed_courses(:one)
  end

  test "visiting the index" do
    visit completed_courses_url
    assert_selector "h1", text: "Completed Courses"
  end

  test "creating a Completed course" do
    visit completed_courses_url
    click_on "New Completed Course"

    fill_in "Course", with: @completed_course.course_id
    fill_in "User", with: @completed_course.user_id
    click_on "Create Completed course"

    assert_text "Completed course was successfully created"
    click_on "Back"
  end

  test "updating a Completed course" do
    visit completed_courses_url
    click_on "Edit", match: :first

    fill_in "Course", with: @completed_course.course_id
    fill_in "User", with: @completed_course.user_id
    click_on "Update Completed course"

    assert_text "Completed course was successfully updated"
    click_on "Back"
  end

  test "destroying a Completed course" do
    visit completed_courses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Completed course was successfully destroyed"
  end
end
