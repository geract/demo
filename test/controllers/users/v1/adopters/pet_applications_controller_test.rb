require "test_helper"

class Users::V1::Adopters::PetApplicationsControllerTest < ActionDispatch::IntegrationTest
  def test_create_success
    @adopter = create(:adopter, :with_profile_completed)
    @credentials = @adopter.create_token
    @adopter.save
    @pet = create(:pet, :complete)

    post adopters_pet_applications_path,
      params: {pet_application: {pet_id: @pet.id}},
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    @pet_application = PetApplication.last

    assert_response :ok
    assert_equal @pet.applications.last, @pet_application
    assert_equal @pet.organization, @pet_application.organization
  end
end
