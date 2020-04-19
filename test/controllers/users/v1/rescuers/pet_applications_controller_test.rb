require "test_helper"

class Users::V1::Rescuers::PetApplicationControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:rescuer_admin, :complete)
    @credentials = @user.create_token
    @user.save
  end

  def test_index_success
    2.times { create(:pet_application) }

    get rescuers_pet_applications_path, headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('applications')
    assert api_response['applications'].size >= 2
    assert api_response['applications'][0]['days_listed'].present?
    assert api_response['applications'][0]['date_listed'].present?
    assert api_response['applications'][0]['total_applications'].present?
  end
end
