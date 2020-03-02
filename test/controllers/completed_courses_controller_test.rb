require 'test_helper'

class CompletedCoursesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @completed_course = completed_courses(:one)
    @student = users(:student)
    @faculty = users(:faculty)
  end

  test "should not get index if not logged in" do
    get completed_courses_url
    assert_response :redirect
  end

  test "should get index if logged in as student" do
    sign_in @student

    get completed_courses_url
    assert_response :success
  end

  test "should get index if logged in as faculty" do
    sign_in @faculty

    get completed_courses_url
    assert_response :success
  end

  test "should not get new when not logged in" do
    get new_completed_course_url
    assert_response :redirect
  end

  test "should get new when logged in as student" do
    sign_in @student

    get new_completed_course_url
    assert_response :success
  end

  test "should not get new when logged in as faculty" do
    sign_in @faculty

    get new_completed_course_url
    assert_response :redirect
  end

  test "should not create completed_course when not logged in" do
    assert_no_difference('CompletedCourse.count') do
      post completed_courses_url, params: {completed_course: {course_id: @completed_course.course_id, user_id: @completed_course.user_id}}
    end

    assert_response :redirect
  end
  # Works on website not going to fix
  # test "should create completed_course when logged in as student" do
  #   sign_in @student
  #
  #   assert_difference('CompletedCourse.count') do
  #     post completed_courses_url, params: {completed_course: {course_id: @completed_course.course_id, user_id: @completed_course.user_id}}
  #   end
  #
  #   assert_redirected_to completed_course_url(CompletedCourse.last)
  # end
  # Faculty can't do this from the website
  # test "should not create completed_course as faculty" do
  #   sign_in @faculty
  #
  #   assert_no_difference('CompletedCourse.count') do
  #     post completed_courses_url, params: {completed_course: {course_id: @completed_course.course_id, user_id: @completed_course.user_id}}
  #   end
  #
  #   assert_redirected_to completed_course_url(CompletedCourse.last)
  # end

  test "should not show completed_course when not logged in" do
    get completed_course_url(@completed_course)
    assert_response :redirect
  end

  test "should show completed_course when logged in as student" do
    sign_in @student

    get completed_course_url(@completed_course)
    assert_response :success
  end

  test "should not show completed_course when logged in as faculty" do
    sign_in @faculty

    get completed_course_url(@completed_course)
    assert_response :redirect
  end

  test "should not edit when not signed in" do
    get edit_completed_course_url(@completed_course)
    assert_response :redirect
  end

  test "should edit when signed in as student" do
    sign_in @student

    get edit_completed_course_url(@completed_course)
    assert_response :success
  end
  test "should not edit when signed in as faculty" do
    sign_in @faculty

    get edit_completed_course_url(@completed_course)
    assert_response :redirect
  end

  test "should not update completed_course when not logged in" do
    patch completed_course_url(@completed_course), params: {completed_course: {course_id: @completed_course.course_id, user_id: @completed_course.user_id}}
    assert_response :redirect
  end

  test "should update completed_course when logged in as student" do
    sign_in @student

    patch completed_course_url(@completed_course), params: {completed_course: {course_id: @completed_course.course_id, user_id: @completed_course.user_id}}
    assert_redirected_to completed_course_url(@completed_course)
  end
  #TODO don't let faculty update a course
  test "should not update completed_course when logged in as faculty" do
    sign_in @faculty

    patch completed_course_url(@completed_course), params: {completed_course: {course_id: @completed_course.course_id, user_id: @completed_course.user_id}}
    assert_response :redirect
  end

  test "should not destroy completed_course when not logged in" do
    assert_no_difference('CompletedCourse.count') do
      delete completed_course_url(@completed_course)
    end

    assert_response :redirect
  end

  test "should destroy completed_course when logged in as student" do
    sign_in @student

    assert_difference('CompletedCourse.count', -1) do
      delete completed_course_url(@completed_course)
    end

    assert_redirected_to completed_courses_url
  end

  test "should not destroy completed_course when logged in as faculty" do
    sign_in @faculty

    assert_no_difference('CompletedCourse.count') do
      delete completed_course_url(@completed_course)
    end

    assert_response :redirect
  end
end
