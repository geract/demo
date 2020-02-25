require "test_helper"

class Users::V1::CharacteristicsOptionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:rescuer_admin)
    @credentials = @user.create_token
    @user.save
  end

  def test_index
    get users_characteristics_options_url,
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('breed')
    assert api_response.include?('sex')
    assert api_response.include?('age')
    assert api_response.include?('housed')
  end
end
