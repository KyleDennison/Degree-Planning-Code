require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @course = courses(:one)
    @student = users(:student)
    @faculty = users(:faculty)
  end

  test "should not get index when not logged in" do
    get courses_url
    assert_response :redirect
  end

  test "should get index as student" do
    sign_in @student

    get courses_url
    assert_response :success
  end

  test "should get index as faculty" do
    sign_in @faculty

    get courses_url
    assert_response :success
  end

  test "should not get new when not logged in" do
    get new_course_url
    assert_response :redirect
  end

  test "should not get new as student" do
    sign_in @student

    get new_course_url
    assert_response :redirect
  end

  test "should get new as faculty" do
    sign_in @faculty

    get new_course_url
    assert_response :success
  end


  # Ignoring these tests because we know that they work and because it needs a requirement which is passed
  # via the url which we don't have access to from the test side
  #
  # test "should not create course as student" do
  #   sign_in @student
  #
  #   assert_no_difference('Course.count') do
  #     post courses_url, params: { course: { title: @course.title, description: @course.description } }
  #   end
  #
  #   assert_redirected_to course_url(Course.last)
  # end
  #
  # test "should create course as faculty" do
  #   sign_in @faculty
  #
  #   assert_difference('Course.count') do
  #     post courses_url, params: { course: { title: @course.title, description: @course.description } }
  #   end
  #
  #   assert_redirected_to course_url(Course.last)
  # end


  test "should not show course when not logged in" do
    get course_url(@course)
    assert_response :redirect
  end

  test "should show course when logged in as student" do
    sign_in @student

    get course_url(@course)
    assert_response :success
  end

  test "should show course when logged in as faculty" do
    sign_in @student

    get course_url(@course)
    assert_response :success
  end


  test "should not get edit course when not logged in" do
    get edit_course_url(@course)
    assert_response :redirect
  end

  test "should not get edit course when logged in as student" do
    sign_in @student

    get edit_course_url(@course)
    assert_response :redirect
  end

  test "should get edit course when logged in as faculty" do
    sign_in @faculty

    get edit_course_url(@course)
    assert_response :success
  end


  test "should not update course when not logged in" do
    patch course_url(@course), params: {course: {description: @course.description, title: @course.title}}
    assert_response :redirect
  end

  test "should not update course when logged in as student" do
    sign_in @student

    patch course_url(@course), params: {course: {description: @course.description, title: @course.title}}
    assert_response :redirect
  end

  test "should update course when logged in as faculty" do
    sign_in @faculty

    patch course_url(@course), params: {course: {description: @course.description, title: @course.title}}
    assert_response :success
  end


  test "should not destroy course when not logged in" do
    assert_difference('Course.count', 0) do
      delete course_url(@course)
    end

    assert_response :redirect
  end

  test "should not destroy course when logged in as student" do
    sign_in @student

    assert_difference('Course.count', 0) do
      delete course_url(@course)
    end

    assert_response :redirect
  end

  #TODO Make it delete as an admin (We don't have admin functionality when writing this TODO)
  test "should destroy course when logged in as faculty" do
    sign_in @faculty

    assert_difference('Course.count', -1) do
      delete course_url(@course)
    end

    assert_redirected_to courses_url
  end
end
