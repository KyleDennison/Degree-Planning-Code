require 'test_helper'

class MajorsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @major = majors(:computer_science)
    @student = users(:student)
    @faculty = users(:faculty)
  end

  test "should not get index if not logged in" do
    get majors_url
    assert_response :redirect
  end

  test "should get index if logged in" do
    sign_in @student

    get majors_url
    assert_response :success
  end

  test "should get new if faculty" do
    sign_in @faculty

    get new_major_url
    assert_response :success
  end

  test "should not create major if not signed in" do
    assert_no_difference('Major.count') do
      post majors_url, params: { major: { title: "Hehehe" }}
    end
  end

  test "should not create major if student" do
    sign_in @student

    assert_no_difference('Major.count') do
      post majors_url, params: { major: { title: "Hahaha" }}
    end
  end

  test "should create major if faculty" do
    sign_in @faculty

    assert_difference('Major.count') do
      post majors_url, params: { major: { title: "Philosophy" } }
    end

    #assert_redirected_to major_url(Major.last)
  end

  test "should show major if logged in" do
    sign_in @student

    get major_url(@major)
    assert_response :success
  end

  test "should get edit if faculty" do
    sign_in @faculty

    get edit_major_url(@major)
    assert_response :success
  end

  test "should update major if faculty" do
    sign_in @faculty

    patch major_url(@major), params: { major: { title: "New Computer Science" } }
    #assert_redirected_to major_url(@major)
  end

  test "should never destroy major" do
    sign_in @faculty

    # assert_difference('Major.count', -1) do
    #   delete major_url(@major)
    # end

    assert_no_difference('Major.count') do
      delete major_url(@major)
    end

    #assert_redirected_to majors_url
  end
end
