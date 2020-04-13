require "test_helper"

class Users::V1::Adopters::PersonalCoAdoptersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @adopter = build(:adopter, :with_application_personal_co_adopter)
    @credentials = @adopter.create_token
    @adopter.save
  end

  def test_show
    # @adopter.profile.co_adopter = build(:co_adopter)
    # @credentials = @adopter.create_token
    # @adopter.save
    skip

    get adopters_personal_co_adopter_path,
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert_equal api_response, build(:personal_co_adopter_params)
  end

  def test_update
    skip
    patch adopters_personal_co_adopter_path,
      params: build(:personal_co_adopter_params),
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    @application = PetApplication.last

    assert_response :success
    assert @application.filling?
    assert @application.co_adopter.present?
    assert @application.co_adopter.profile.present?
    assert @application.co_adopter.profile.address.present?
    assert @application.co_adopter.profile.employment.present?
    assert @application.co_adopter.profile.employment.address.present?
    assert @application.applicationable.pet_info.personal.present?
    assert @application.applicationable.personal_final?
  end

  def test_redirect_to_first_step
    @adopter = build(:adopter, :without_pet_info)
    @credentials = @adopter.create_token
    @adopter.save

    patch adopters_personal_co_adopter_path,
      params: {},
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)
      
    assert_response :redirect
    assert_redirected_to adopters_personal_info_path
  end
end
