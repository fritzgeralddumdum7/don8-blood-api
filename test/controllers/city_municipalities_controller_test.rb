require "test_helper"

class CityMunicipalitiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get city_municipalities_index_url
    assert_response :success
  end

  test "should get show" do
    get city_municipalities_show_url
    assert_response :success
  end
end
