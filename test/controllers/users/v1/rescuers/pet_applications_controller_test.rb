require "test_helper"

class Users::V1::Rescuers::PetApplicationControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:rescuer_admin, :complete)
    @credentials = @user.create_token
    @user.save
    @application = build(:pet_application, :completed, applicationable: build(:pet_application_dog, :completed)).save
  end

  def test_index_success
    pet1 = create(:pet, :complete)
    pet2 = create(:pet, :complete, name: 'Fido')
    create(:pet_application, :completed, applicationable: build(:pet_application_dog, :personal_info))
    create(:pet_application, :completed, applicationable: build(:pet_application_dog, :personal_info))

    get rescuers_pet_applications_path, headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('applications')
    assert api_response['applications'].any?
    assert api_response['applications'][0]['days_listed'].present?
    assert api_response['applications'][0]['date_listed'].present?
    assert api_response['applications'][0]['total_applications'].present?
  end
end
