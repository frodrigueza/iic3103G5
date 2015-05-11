require 'test_helper'

class B2bControllerTest < ActionController::TestCase
  test "should get documentation" do
    get :documentation
    assert_response :success
  end

end
