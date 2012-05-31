require 'test_helper'

class UtilyControllerTest < ActionController::TestCase
  test "should get fbtest" do
    get :fbtest
    assert_response :success
  end

end
