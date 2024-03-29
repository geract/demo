require "test_helper"

class Users::V1::Rescuers::PetsStatusesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:rescuer_admin, :complete)
    @credentials = @user.create_token
    @user.save
    @organization = create(:organization, :complete, rescuer_admin_profile: @user.profile)
  end

  def test_update_success
    pet = create(:pet, :complete, organization: @organization)

    put rescuers_pets_status_path(pet),
      params: { pet: { status: 'archive', reason_code: 'pet_adopted' } },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    assert_response :success
  end

  def test_update_error
    pet = create(:pet, :complete, organization: @organization)
    
    put rescuers_pets_status_path(pet),
      params: { pet: { status: 'archive'} },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :unprocessable_entity
    assert api_response.include?('errors')
  end
end
