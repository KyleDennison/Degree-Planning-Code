require 'test_helper'

class RequirementsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @requirement = requirements(:comp_sci_maths)
    @student = users(:student)
    @faculty = users(:faculty)
  end

  test "should not get index when not logged in" do
    get requirements_url
    assert_response :redirect
  end

  test "should not get index when logged in as student" do
    sign_in @student

    get requirements_url
    assert_response :redirect
  end

  test "should not get index when logged in as faculty" do
    sign_in @faculty

    get requirements_url
    assert_response :redirect
  end

  test "should not get new when not logged in" do
    get new_requirement_url
    assert_response :redirect
  end

  test "should not get new when logged in as student" do
    sign_in @student

    get new_requirement_url
    assert_response :redirect
  end

  test "should get new when logged in as faculty" do
    sign_in @faculty

    get new_requirement_url
    assert_response :success
  end

  # Testing isn't possible with requirements because we designed the system weirdly
  # test "should create requirement" do
  #   assert_difference('Requirement.count') do
  #     post requirements_url, params: { requirement: {  } }
  #   end
  #
  #   assert_redirected_to requirement_url(Requirement.last)
  # end

  test "should not show requirement when not logged in" do
    get requirement_url(@requirement)
    assert_response :redirect
  end

  test "should show requirement when logged in as student" do
    sign_in @student

    get requirement_url(@requirement)
    assert_response :success
  end

  test "should show requirement when logged in as faculty" do
    sign_in @faculty

    get requirement_url(@requirement)
    assert_response :success
  end

  test "should not get edit when not logged in" do
    get edit_requirement_url(@requirement)
    assert_response :redirect
  end

  test "should not get edit when logged in as student" do
    sign_in @student

    get edit_requirement_url(@requirement)
    assert_response :redirect
  end

  test "should get edit when logged in as faculty" do
    sign_in @faculty

    get edit_requirement_url(@requirement)
    assert_response :success
  end

  # Update messed up for the same reason that create is
  # test "should update requirement" do
  #   patch requirement_url(@requirement), params: { requirement: {  } }
  #   assert_redirected_to requirement_url(@requirement)
  # end



  test "should not destroy requirement when not logged in" do
    assert_no_difference('Requirement.count', -1) do
      delete requirement_url(@requirement)
    end

    assert_response :redirect
  end

  test "should not destroy requirement when signed in as student" do
    sign_in @student

    assert_no_difference('Requirement.count', -1) do
      delete requirement_url(@requirement)
    end

    assert_response :redirect
  end

  test "should not destroy requirement when signed in as faculty" do
    sign_in @faculty

    assert_no_difference('Requirement.count', -1) do
      delete requirement_url(@requirement)
    end

    assert_response :redirect
  end
end
