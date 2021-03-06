require 'test_helper'

class ChemicalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @chemical = chemicals(:one)
  end

  test "should get index" do
    get chemicals_url
    assert_response :success
  end

  test "should get new" do
    get new_chemical_url
    assert_response :success
  end

  test "should create chemical" do
    assert_difference('Chemical.count') do
      post chemicals_url, params: { chemical: {  } }
    end

    assert_redirected_to chemical_url(Chemical.last)
  end

  test "should show chemical" do
    get chemical_url(@chemical)
    assert_response :success
  end

  test "should get edit" do
    get edit_chemical_url(@chemical)
    assert_response :success
  end

  test "should update chemical" do
    patch chemical_url(@chemical), params: { chemical: {  } }
    assert_redirected_to chemical_url(@chemical)
  end

  test "should destroy chemical" do
    assert_difference('Chemical.count', -1) do
      delete chemical_url(@chemical)
    end

    assert_redirected_to chemicals_url
  end
end
