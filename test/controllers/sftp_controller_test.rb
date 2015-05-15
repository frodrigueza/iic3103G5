require 'test_helper'

class SftpControllerTest < ActionController::TestCase
  test "should get get_new_orders" do
    get :get_new_orders
    assert_response :success
  end

end
