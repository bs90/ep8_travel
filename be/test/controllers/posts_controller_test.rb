require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get create_presigned_url" do
    get posts_create_presigned_url_url
    assert_response :success
  end
end
