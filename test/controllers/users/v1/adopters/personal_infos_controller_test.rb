require "test_helper"

class Users::V1::Adopters::PersonalInfosControllerTest < ActionDispatch::IntegrationTest
  def test_show
    @adopter = build(:adopter, :with_personal_info)
    @credentials = @adopter.create_token
    @adopter.save

    get adopters_personal_info_path,
    headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response
    assert api_response['profile']
    refute api_response['profile']['has_co_adopter']
    assert api_response['profile']['address_attributes']
    assert api_response['profile']['employment_attributes']
    assert api_response['profile']['employment_attributes']['address_attributes']
    assert api_response['profile']['pet_info_attributes']['personal']
  end

  def test_create
    @adopter = build(:adopter, :without_pet_info)
    @credentials = @adopter.create_token
    @adopter.save

    patch adopters_personal_info_path,
      params: build(:personal_info_params),
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    @profile = @adopter.reload.profile

    assert_response :success
    assert @profile.personal_co_adopter?
    assert @profile.address
    assert @profile.employment
    assert @profile.employment.address
    assert @profile.pet_info
    assert @profile.pet_info.personal
  end

  def test_update
    @adopter = build(:adopter, :with_personal_final)
    @credentials = @adopter.create_token
    @adopter.save
    params = Users::Adopters::Profile::PersonalInfoPresenter.new(@adopter).as_json
    params[:profile][:has_co_adopter] = false
    params[:profile][:birthday] = Date.today

    patch adopters_personal_info_path,
      params: params,
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    @profile = @adopter.reload.profile

    assert_response :success
    assert @profile.personal_final?
    assert @profile.birthday, Date.today
    assert @profile.address
    assert @profile.employment
    assert @profile.employment.address
    assert @profile.pet_info
    assert @profile.pet_info.personal
  end
end
