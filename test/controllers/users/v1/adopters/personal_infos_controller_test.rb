require "test_helper"

class Users::V1::Adopters::PersonalInfosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @adopter = build(:adopter)
    @credentials = @adopter.create_token
    @adopter.save
  end

  def test_show
    @adopter = build(:adopter, :with_application_personal_info)
    @credentials = @adopter.create_token
    @adopter.save
    
    get adopters_personal_info_path,
    headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.present?
    assert api_response['profile'].present?
    refute api_response['profile']['has_co_adopter'].present?
    assert api_response['profile']['address_attributes'].present?
    assert api_response['profile']['employment_attributes'].present?
    assert api_response['profile']['employment_attributes']['address_attributes'].present?
    assert api_response['profile']['pet_info_attributes']['personal'].present?
  end

  def test_update
    patch adopters_personal_info_path,
      params: build(:personal_info_params),
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    @profile = @adopter.reload.profile

    assert_response :success
    assert @profile.personal_co_adopter?
    assert @profile.address.present?
    assert @profile.employment.present?
    assert @profile.employment.address.present?
    assert @profile.pet_info.personal.present?
  end
  
  def test_update_and_skip_personal_co_adopter
    patch adopters_personal_info_path,
    params: build(:personal_info_params),
    headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)
    
    @profile = @adopter.reload.profile
    
    assert_response :success
    refute @profile.personal_final?
  end
end
