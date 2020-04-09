require "test_helper"

class Users::V1::Adopters::Applications::PersonalInfosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @adopter = build(:adopter)
    @credentials = @adopter.create_token
    @adopter.save
  end

  def test_show
    @adopter = build(:adopter, :with_application_personal_co_adopter)
    @adopter.application.applicationable.state = 'personal_info'
    @credentials = @adopter.create_token
    @adopter.save

    get adopters_applications_personal_info_path,
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert_equal api_response, build(:personal_info_params)
  end

  def test_update
    create(:pet, :complete)
    patch adopters_applications_personal_info_path,
      params: build(:personal_info_params),
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    @application = PetApplication.last

    assert_response :success
    assert @application.filling?
    assert @application.profile.present?
    assert @application.profile.address.present?
    assert @application.profile.employment.present?
    assert @application.profile.employment.address.present?
    assert @application.applicationable.personal_co_adopter?
    assert @application.applicationable.pet_info.personal.present?
  end

  def test_update_error
    patch adopters_applications_personal_info_path,
      params: {application: { has_co_adopter: false, profile_attributes: {phone_number: '1234567890'}}},
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    assert_response :unprocessable_entity
  end
end
