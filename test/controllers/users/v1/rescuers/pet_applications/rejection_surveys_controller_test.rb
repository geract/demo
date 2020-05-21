require 'test_helper'

class Users::V1::Rescuers::PetApplications::RejectionSurveysControllerTest < ActionDispatch::IntegrationTest
  def setup
    admin = build(:rescuer_admin, :complete)
    organization = admin.profile.organization
    @user = create(:rescuer, :complete, status: 'activated', profile: build(:rescuer_profile, first_name: 'Bruce', organization: organization))
    pet = create(:pet, organization: organization, name: 'Boomer', added_by: admin)
    @pet_application = create(:pet_application, pet: pet, organization: pet.organization)
    @credentials = @user.create_token
    @user.save
  end

  def test_index
    get rescuers_pet_application_rejection_surveys_path(@pet_application.id),
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert_equal 3, api_response.length
    assert api_response.all? { |obj| obj.key?('question') }
    assert api_response.all? { |obj| obj.key?('answers') }
  end
end
