require "test_helper"

class RequestTypesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get request_types_index_url
    assert_response :success
  end
end
