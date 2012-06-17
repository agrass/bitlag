require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get add_events" do
    get :add_events
    assert_response :success
  end

end
