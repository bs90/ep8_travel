require 'test_helper'

class UploadFilesControllerTest < ActionDispatch::IntegrationTest
  test 'should get presigned_url' do
    get upload_files_presigned_url_url
    assert_response :success
  end
end
