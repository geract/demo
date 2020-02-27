require "test_helper"

class Users::V1::RecuerStatusesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:rescuer_admin)
    @credentials = @user.create_token
    @user.save
  end

  def test_update_success
    rescuer = create(:rescuer)

    put users_rescuer_status_path(rescuer),
      params: { rescuer: { status: 'archive' } },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('rescuer')
    assert api_response['rescuer']['status'], 'archived'
  end
end
