require "test_helper"

class Users::V1::Rescuers::SurveysControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:rescuer)
    @credentials = @user.create_token
    @user.save
  end

  def test_index
    get rescuers_surveys_url(type: 'pet_application_rejection'),
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert_equal 3, api_response['survey'].length
    assert api_response['survey'].all? { |obj| obj.key?('question') }
    assert api_response['survey'].all? { |obj| obj.key?('answers') }
  end
end
