require 'test_helper'

class Admins::OrderDatailsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get admins_order_datails_update_url
    assert_response :success
  end

end
