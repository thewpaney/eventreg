require 'test_helper'

class EventControllerTest < ActionController::TestCase
  test "should get register" do
    get :register
    assert_response :success
  end

end
