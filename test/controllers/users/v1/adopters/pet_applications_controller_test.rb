require "test_helper"

class Users::V1::Adopters::PetApplicationsControllerTest < ActionDispatch::IntegrationTest
  def test_create_success
    @adopter = create(:adopter, :with_profile_completed)
    @credentials = @adopter.create_token
    @adopter.save
    @pet = create(:pet, :complete)

    post adopters_pet_applications_path,
      params: {pet_application: {pet_id: @pet.id, adopter_profile_id: @adopter.profile.id}},
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    assert_response :ok
  end

  def test_create_error
    @adopter = create(:adopter, :with_profile_completed)
    @credentials = @adopter.create_token
    @adopter.save
    @pet = create(:pet, :complete)

    post adopters_pet_applications_path,
      params: {pet_application: {adopter_profile_id: @adopter.profile.id}},
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :unprocessable_entity
    assert api_response.include?('errors')
    assert api_response['errors'].any?
  end
end
