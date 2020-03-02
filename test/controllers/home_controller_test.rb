require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index at root" do

    # The root is home#index
    get root_url
    assert_response :success
  end

end
