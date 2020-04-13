require "test_helper"

class Users::V1::Adopters::FinalsControllerTest < ActionDispatch::IntegrationTest
  def test_show
    @adopter = build(:adopter, :with_profile_home)
    @credentials = @adopter.create_token
    @adopter.save

    get adopters_personal_final_path,
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response
    assert api_response['profile']
    assert api_response['profile']['pet_info_attributes']
    assert api_response['profile']['pet_info_attributes']['personal']
    assert api_response['profile']['pet_info_attributes']['animal_history']
    assert api_response['profile']['pet_info_attributes']['veterinarian_extra']
    assert api_response['profile']['veterinarian_attributes']
    assert api_response['profile']['veterinarian_attributes']['address_attributes']
  end

  def test_create
    @adopter = build(:adopter, :with_personal_final)
    @credentials = @adopter.create_token
    @adopter.save

    patch adopters_personal_final_path,
      params: build(:personal_final_params),
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    @profile = @adopter.reload.profile

    assert_response :success
    assert @profile.home?
    assert @profile.veterinarian
    assert @profile.veterinarian.address
    assert @profile.pet_info.personal
    assert @profile.pet_info.animal_history
    assert @profile.pet_info.veterinarian_extra
  end

  def test_update
    @adopter = build(:adopter, :with_profile_home)
    @credentials = @adopter.create_token
    @adopter.save

    params = build(:personal_final_params)
    params[:profile].delete(:veterinarian_attributes)
    params[:profile][:pet_info_attributes][:veterinarian_extra][:has_veterinarian] = false

    patch adopters_personal_final_path,
      params: params,
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    @profile = @adopter.reload.profile

    assert_response :success
    assert @profile.home?
    refute @profile.veterinarian
    assert_equal @profile.pet_info.veterinarian_extra['has_veterinarian'], 'false'
  end

  def test_redirect_to_first_step
    @adopter = build(:adopter, :without_pet_info)
    @credentials = @adopter.create_token
    @adopter.save

    patch adopters_personal_final_path,
      params: {},
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)
      
    assert_response :redirect
    assert_redirected_to adopters_personal_info_path
  end

  def test_redirect_to_next_step
    @adopter = build(:adopter, :with_co_adopter)
    @credentials = @adopter.create_token
    @adopter.save
    
    patch adopters_personal_final_path,
      params: {},
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)
      
    assert_response :redirect
    assert_redirected_to adopters_personal_co_adopter_path
  end
end
