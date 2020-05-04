require "test_helper"

class Users::V1::Adopters::AgreementsControllerTest < ActionDispatch::IntegrationTest
  def test_show
    @adopter = build(:adopter, :with_profile_references)
    @credentials = @adopter.create_token
    @adopter.save

    get adopters_add_references_path,
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response
    assert api_response['profile']
    assert api_response['profile']['references_attributes'].any?
  end

  def test_create
    @adopter = build(:adopter, :with_profile_completed)
    @credentials = @adopter.create_token
    @adopter.save

    patch adopters_add_references_path,
      params: build(:adopter_profile_references_params),
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    @profile = @adopter.reload.profile

    assert_response :success
    assert @profile.completed?
    assert @profile.references.any?
  end

  def test_update
    @adopter = build(:adopter, :with_profile_references)
    @credentials = @adopter.create_token
    @adopter.save

    patch adopters_add_references_path,
      params: Users::Adopters::Profile::ReferencesPresenter.new(@adopter).as_json,
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    @profile = @adopter.reload.profile

    assert_response :success
    assert @profile.completed?
    assert @profile.references.any?
  end

  def test_redirect_to_profile_step
    @adopter = build(:adopter, :with_profile_agreements)
    @credentials = @adopter.create_token
    @adopter.save
    
    patch adopters_add_references_path,
      params: {},
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :conflict
    assert api_response['error']
    assert_equal 'agreements', api_response['status']
  end
end
