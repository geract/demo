require "test_helper"

class Users::V1::Rescuers::RecuerStatusesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = build(:rescuer_admin, :complete)
    @credentials = @user.create_token
    @user.save
    @organization = create(:organization, :complete,
                           name: 'Happy tails',
                           email: 'happytails@pph.com',
                           '5013c': 'random number',
                           rescuer_admin_profile: @user.profile)
  end

  def test_update_success
    profile = create(:rescuer_profile, :complete, organization: @organization)

    put rescuers_rescuer_status_path(profile.rescuer),
      params: { rescuer: { status: 'archive' } },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('rescuer')
    assert_equal api_response['rescuer']['status'], 'archived'
  end
end
