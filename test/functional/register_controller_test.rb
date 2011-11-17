require 'test_helper'

class RegisterControllerTest < ActionController::TestCase
  test "should get investor" do
    get :investor
    assert_response :success
  end

  test "should get entrepreneur" do
    get :entrepreneur
    assert_response :success
  end

end
