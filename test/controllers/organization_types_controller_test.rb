require "test_helper"

class OrganizationTypesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get organization_types_index_url
    assert_response :success
  end
end
