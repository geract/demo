require "test_helper"

class Users::V1::Rescuers::Pets::PetApplicationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = build(:rescuer_admin, :complete)
    @organization = @user.profile.organization
    @credentials = @user.create_token
    @user.save
  end

  def test_index_success
    @pet = create(:pet, organization: @organization, name: 'Pet1', added_by: @user)
    create(:pet_application, pet: @pet)

    get rescuers_pet_pet_applications_path(pet_id: @pet.id),
    headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.any?
    assert api_response[0]['id'].present?
    assert api_response[0]['adopter'].present?
    assert_equal api_response[0]['adopter']['first_name'], 'Ale'
    assert_equal api_response[0]['adopter']['last_name'], 'Jandra'
    assert api_response[0]['adopter']['address_attributes'].present?
    assert_equal api_response[0]['adopter']['address_attributes']['city'], 'Mountain View'
    assert_equal api_response[0]['adopter']['address_attributes']['state'], 'CA'
  end

  def test_index_error
    get rescuers_pet_pet_applications_path(pet_id: 987),
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    assert_response :unprocessable_entity
  end
end
