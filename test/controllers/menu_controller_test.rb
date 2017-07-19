require 'test_helper'

class MenuControllerTest < ActionDispatch::IntegrationTest
  test "should get view" do
    get menu_view_url
    assert_response :success
  end

end
