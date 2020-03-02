require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @student = users(:student)
    @faculty = users(:faculty)
  end

  test "should get show for student" do
    sign_in @student

    get user_url(@student)
    assert_response :success
  end

  test "should get show for faculty" do
    sign_in @faculty

    get user_url(@faculty)
    assert_response :success
  end
end
