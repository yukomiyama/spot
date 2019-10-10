require 'test_helper'

class UserCommunitiesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_communities_create_url
    assert_response :success
  end

end
