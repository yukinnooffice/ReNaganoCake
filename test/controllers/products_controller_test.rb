require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get products_index_url
    assert_response :success
  end

  test "should get show" do
    get products_show_url
    assert_response :success
  end

  test "should get about" do
    get products_about_url
    assert_response :success
  end

  test "should get top" do
    get products_top_url
    assert_response :success
  end

end
