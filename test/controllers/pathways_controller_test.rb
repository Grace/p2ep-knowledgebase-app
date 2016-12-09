require 'test_helper'

class PathwaysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pathway = pathways(:one)
  end

  test "should get index" do
    get pathways_url
    assert_response :success
  end

  test "should get new" do
    get new_pathway_url
    assert_response :success
  end

  test "should create pathway" do
    assert_difference('Pathway.count') do
      post pathways_url, params: { pathway: {  } }
    end

    assert_redirected_to pathway_url(Pathway.last)
  end

  test "should show pathway" do
    get pathway_url(@pathway)
    assert_response :success
  end

  test "should get edit" do
    get edit_pathway_url(@pathway)
    assert_response :success
  end

  test "should update pathway" do
    patch pathway_url(@pathway), params: { pathway: {  } }
    assert_redirected_to pathway_url(@pathway)
  end

  test "should destroy pathway" do
    assert_difference('Pathway.count', -1) do
      delete pathway_url(@pathway)
    end

    assert_redirected_to pathways_url
  end
end
