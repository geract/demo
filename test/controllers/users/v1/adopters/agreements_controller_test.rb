require "test_helper"

class Users::V1::Adopters::AgreementsControllerTest < ActionDispatch::IntegrationTest
  def test_show
    @adopter = build(:adopter, :with_profile_references)
    @credentials = @adopter.create_token
    @adopter.save

    get adopters_agreements_path,
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response
    assert api_response['profile']
    assert api_response['profile']['home_visit_agreement']
    assert api_response['profile']['adoption_fee_agreement']
  end

  def test_create
    @adopter = build(:adopter, :with_profile_agreements)
    @credentials = @adopter.create_token
    @adopter.save

    patch adopters_agreements_path,
      params: build(:adopter_profile_agreements_params),
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    @profile = @adopter.reload.profile

    assert_response :success
    assert @profile.add_references?
    assert @profile.home_visit_agreement
    assert @profile.adoption_fee_agreement
  end

  def test_update
    @adopter = build(:adopter, :with_profile_references)
    @credentials = @adopter.create_token
    @adopter.save

    patch adopters_agreements_path,
      params: Users::Adopters::Profile::AgreementsPresenter.new(@adopter).as_json,
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    @profile = @adopter.reload.profile

    assert_response :success
    assert @profile.add_references?
    assert @profile.home_visit_agreement
    assert @profile.adoption_fee_agreement
  end

  def test_redirect_to_profile_step
    @adopter = build(:adopter, :with_profile_lifestyle)
    @credentials = @adopter.create_token
    @adopter.save
    
    patch adopters_agreements_path,
      params: {},
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :unprocessable_entity
    assert api_response['error']
    assert_equal 'lifestyle', api_response['status']
  end
end
