require 'test_helper'

class AppControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get app_new_url
    assert_response :success
  end

end
