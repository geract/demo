require "test_helper"

class Users::V1::Adopters::PersonalCoAdoptersControllerTest < ActionDispatch::IntegrationTest
  def test_show
    @adopter = build(:adopter, :with_co_adopter)
    @credentials = @adopter.create_token
    @adopter.save

    get adopters_personal_co_adopter_path,
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response
    assert api_response['profile']
    assert api_response['profile']['co_adopter_attributes']
    assert api_response['profile']['co_adopter_attributes']['address_attributes']
    assert api_response['profile']['co_adopter_attributes']['employment_attributes']
    assert api_response['profile']['co_adopter_attributes']['employment_attributes']['address_attributes']
    assert api_response['profile']['pet_info_attributes']
    assert api_response['profile']['pet_info_attributes']['personal']
  end

  def test_create
    @adopter = build(:adopter, :with_personal_info)
    @adopter.profile.continue!
    @credentials = @adopter.create_token
    @adopter.save

    patch adopters_personal_co_adopter_path,
      params: build(:personal_co_adopter_params),
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    @profile = @adopter.reload.profile

    assert_response :success
    assert @profile.personal_final?
    assert @profile.co_adopter
    assert @profile.co_adopter.address
    assert @profile.co_adopter.employment
    assert @profile.co_adopter.employment.address
    assert @profile.pet_info.personal
  end

  def test_update
    @adopter = build(:adopter, :with_personal_final)
    @credentials = @adopter.create_token
    @adopter.save

    params = build(:personal_co_adopter_params)
    params[:profile][:co_adopter_attributes][:address_attributes] = { street_line_1: "", street_line_2: "", city: "", state: "", zip_code: "", country: "" }
    params[:profile][:is_address_same_as_adopter] = true

    patch adopters_personal_co_adopter_path,
      params: params,
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    @profile = @adopter.reload.profile

    assert_response :success
    assert @profile.personal_final?
    assert @profile.co_adopter
    assert @profile.co_adopter
    assert @profile.co_adopter.address
    assert @profile.co_adopter.employment
    assert @profile.co_adopter.employment.address
    assert @profile.pet_info.personal
    assert @profile.pet_info.personal['co_adopter_relation']
  end

  def test_redirect_to_profile_step
    @adopter = build(:adopter, :without_pet_info)
    @credentials = @adopter.create_token
    @adopter.save

    patch adopters_personal_co_adopter_path,
      params: {},
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)
      
    api_response = JSON.parse(response.body)

    assert_response :conflict
    assert api_response['error']
    assert_equal 'personal_info', api_response['status']
  end
end
