require "test_helper"

class Users::V1::PetsStatusesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:rescuer_admin)
    @credentials = @user.create_token
    @user.save
  end

  def test_update_success
    pet = create(:pet)

    put users_pets_status_path(pet),
      params: { pet: { status: 'archive', reason_code: 'pet_adopted' } },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('pet')
    assert api_response['pet']['status'], 'archived'
  end

  def test_update_error
    pet = create(:pet)
    
    put users_pets_status_path(pet),
      params: { pet: { status: 'archive'} },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :unprocessable_entity
    assert api_response.include?('pet')
    assert api_response['pet']['name'], pet.name
  end
end
