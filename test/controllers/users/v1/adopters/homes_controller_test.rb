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
      params: build(:adopter_profile_home_params),
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    @profile = @adopter.reload.profile

    assert_response :success
    assert @profile.lifestyle?
    assert @profile.pet_info.home
  end

  def test_redirect_to_first_step
    @adopter = build(:adopter, :without_pet_info)
    @credentials = @adopter.create_token
    @adopter.save

    patch adopters_home_path,
      params: {},
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)
      
    assert_response :redirect
    assert_redirected_to adopters_personal_info_path
  end

  def test_redirect_to_next_step
    @adopter = build(:adopter, :with_co_adopter)
    @credentials = @adopter.create_token
    @adopter.save
    
    patch adopters_home_path,
      params: {},
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)
      
    assert_response :redirect
    assert_redirected_to adopters_personal_co_adopter_path
  end
end
