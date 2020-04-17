require "test_helper"

class Users::V1::Adopters::HomesControllerTest < ActionDispatch::IntegrationTest
  def test_show
    @adopter = build(:adopter, :with_profile_lifestyle)
    @credentials = @adopter.create_token
    @adopter.save

    get adopters_home_path,
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response
    assert api_response['profile']
    assert api_response['profile']['pet_info_attributes']
    assert api_response['profile']['pet_info_attributes']['home']
  end

  def test_create
    @adopter = build(:adopter, :with_profile_home)
    @credentials = @adopter.create_token
    @adopter.save

    patch adopters_home_path,
      params: build(:adopter_profile_home_params),
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    @profile = @adopter.reload.profile

    assert_response :success
    assert @profile.lifestyle?
    assert @profile.pet_info.home
  end

  def test_update
    @adopter = build(:adopter, :with_profile_lifestyle)
    @credentials = @adopter.create_token
    @adopter.save

    patch adopters_home_path,
      params: Users::Adopters::Profile::HomePresenter.new(@adopter).as_json,
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    @profile = @adopter.reload.profile

    assert_response :success
    assert @profile.lifestyle?
    assert @profile.pet_info.home
  end

  def test_redirect_to_profile_step
    @adopter = build(:adopter, :with_personal_final)
    @credentials = @adopter.create_token
    @adopter.save
    
    patch adopters_home_path,
      params: {},
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :unprocessable_entity
    assert api_response['error']
    assert_equal 'personal_final', api_response['status']
  end
end
