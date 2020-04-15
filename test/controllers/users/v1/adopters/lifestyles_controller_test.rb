require "test_helper"

class Users::V1::Adopters::LifestylesControllerTest < ActionDispatch::IntegrationTest
  def test_show
    @adopter = build(:adopter, :with_profile_agreements)
    @credentials = @adopter.create_token
    @adopter.save

    get adopters_lifestyle_path,
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response
    assert api_response['profile']
    assert api_response['profile']['pet_info_attributes']
    assert api_response['profile']['pet_info_attributes']['lifestyle']
  end

  def test_create
    @adopter = build(:adopter, :with_profile_lifestyle)
    @credentials = @adopter.create_token
    @adopter.save

    patch adopters_lifestyle_path,
      params: build(:adopter_profile_lifestyle_params),
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    @profile = @adopter.reload.profile

    assert_response :success
    assert @profile.agreements?
    assert @profile.pet_info.lifestyle
  end

  def test_update
    @adopter = build(:adopter, :with_profile_agreements)
    @credentials = @adopter.create_token
    @adopter.save

    patch adopters_lifestyle_path,
      params: build(:adopter_profile_lifestyle_params),
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    @profile = @adopter.reload.profile

    assert_response :success
    assert @profile.agreements?
    assert @profile.pet_info.lifestyle
  end

  def test_redirect_to_first_step
    @adopter = build(:adopter, :without_pet_info)
    @credentials = @adopter.create_token
    @adopter.save

    patch adopters_lifestyle_path,
      params: {},
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)
      
    assert_response :redirect
    assert_redirected_to adopters_personal_info_path
  end

  def test_redirect_to_next_step
    @adopter = build(:adopter, :with_co_adopter)
    @credentials = @adopter.create_token
    @adopter.save
    
    patch adopters_lifestyle_path,
      params: {},
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)
      
    assert_response :redirect
    assert_redirected_to adopters_personal_co_adopter_path
  end
end
