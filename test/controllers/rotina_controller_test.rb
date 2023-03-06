require "test_helper"

class RotinaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rotina_index_url
    assert_response :success
  end
end
