require 'test_helper'

class SeancesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @seance = seances(:one)
  end

  test "should get index" do
    get seances_url
    assert_response :success
  end

  test "should get new" do
    get new_seance_url
    assert_response :success
  end

  test "should create seance" do
    assert_difference('Seance.count') do
      post seances_url, params: { seance: {  } }
    end

    assert_redirected_to seance_url(Seance.last)
  end

  test "should show seance" do
    get seance_url(@seance)
    assert_response :success
  end

  test "should get edit" do
    get edit_seance_url(@seance)
    assert_response :success
  end

  test "should update seance" do
    patch seance_url(@seance), params: { seance: {  } }
    assert_redirected_to seance_url(@seance)
  end

  test "should destroy seance" do
    assert_difference('Seance.count', -1) do
      delete seance_url(@seance)
    end

    assert_redirected_to seances_url
  end
end
