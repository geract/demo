require "test_helper"

class Users::V1::Rescuers::PetApplications::ApplicationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = build(:rescuer_admin, :complete)
    @credentials = @user.create_token
    @user.save
  end
  
  def test_show_success
    @organization = @user.profile.organization
    @pet_application = create(:pet_application, organization: @organization)

    get rescuers_pet_application_application_path(@pet_application),
      params: {},
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert_equal api_response['co_adopter']['email'], 'test@coadopter.com'
    assert api_response['co_adopter']['address_attributes']
    assert api_response['co_adopter']['employment_attributes']
    assert api_response['pet_info']
    assert api_response['pet_info']['personal']
    assert api_response['pet_info']['home']
    assert api_response['pet_info']['lifestyle']
    assert api_response['pet_info']['animal_history']
    assert api_response['pet_info']['veterinarian_extra']
    assert api_response['veterinarian']['last_name'], 'Dolittle'
  end
end
