require 'test_helper'

class ToolControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get activation" do
    get :activation
    assert_response :success
  end

  test "should get sending" do
    get :sending
    assert_response :success
  end

end
