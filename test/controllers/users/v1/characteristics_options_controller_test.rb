require "test_helper"

class Users::V1::CharacteristicsOptionsCntroller < ActionDispatch::IntegrationTest
  def setup
    login_as_admin
  end

  def test_index
    get users_characteristics_options_url, headers: {'API-VERSION' => '1'}

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('breed')
    assert api_response.include?('sex')
    assert api_response.include?('age')
    assert api_response.include?('housed')
  end
end
