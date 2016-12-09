require 'test_helper'

class ProteinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @protein = proteins(:one)
  end

  test "should get index" do
    get proteins_url
    assert_response :success
  end

  test "should get new" do
    get new_protein_url
    assert_response :success
  end

  test "should create protein" do
    assert_difference('Protein.count') do
      post proteins_url, params: { protein: {  } }
    end

    assert_redirected_to protein_url(Protein.last)
  end

  test "should show protein" do
    get protein_url(@protein)
    assert_response :success
  end

  test "should get edit" do
    get edit_protein_url(@protein)
    assert_response :success
  end

  test "should update protein" do
    patch protein_url(@protein), params: { protein: {  } }
    assert_redirected_to protein_url(@protein)
  end

  test "should destroy protein" do
    assert_difference('Protein.count', -1) do
      delete protein_url(@protein)
    end

    assert_redirected_to proteins_url
  end
end
