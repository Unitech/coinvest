require 'test_helper'

class BacASableControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
