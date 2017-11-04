require 'test_helper'

class AffilatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @affilate = affilates(:one)
  end

  test "should get index" do
    get affilates_url
    assert_response :success
  end

  test "should get new" do
    get new_affilate_url
    assert_response :success
  end

  test "should create affilate" do
    assert_difference('Affilate.count') do
      post affilates_url, params: { affilate: { address: @affilate.address } }
    end

    assert_redirected_to affilate_url(Affilate.last)
  end

  test "should show affilate" do
    get affilate_url(@affilate)
    assert_response :success
  end

  test "should get edit" do
    get edit_affilate_url(@affilate)
    assert_response :success
  end

  test "should update affilate" do
    patch affilate_url(@affilate), params: { affilate: { address: @affilate.address } }
    assert_redirected_to affilate_url(@affilate)
  end

  test "should destroy affilate" do
    assert_difference('Affilate.count', -1) do
      delete affilate_url(@affilate)
    end

    assert_redirected_to affilates_url
  end
end
