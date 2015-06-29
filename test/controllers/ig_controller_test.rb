require 'test_helper'

class IgControllerTest < ActionController::TestCase
  test "should get post_promociones" do
    get :post_promociones
    assert_response :success
  end

end
