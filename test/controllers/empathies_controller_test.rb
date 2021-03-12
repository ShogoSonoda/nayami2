require "test_helper"

class EmpathiesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get empathies_create_url
    assert_response :success
  end

  test "should get destroy" do
    get empathies_destroy_url
    assert_response :success
  end
end
