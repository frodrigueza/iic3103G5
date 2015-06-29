require 'test_helper'

class DashboardsControllerTest < ActionController::TestCase
  test "should get wharehouses" do
    get :wharehouses
    assert_response :success
  end

end
