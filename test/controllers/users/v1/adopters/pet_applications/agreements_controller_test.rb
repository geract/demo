require "test_helper"

class Users::V1::Adopters::Applications::AgreementsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @adopter = build(:adopter, :with_application_agreements)
    @credentials = @adopter.create_token
    @adopter.save
  end

  def test_show
    @adopter = build(:adopter, :with_application_references)
    @adopter.application.state = 'agreements'
    @credentials = @adopter.create_token
    @adopter.save

    get adopters_applications_agreements_path,
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert_equal api_response, build(:agreements_params)
  end

  def test_update
    patch adopters_applications_agreements_path,
      params: build(:agreements_params),
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

      @application = PetApplication.last

      assert_response :success
      assert @application.add_references?
      assert @application.home_visit_agreement
      assert @application.adoption_fee_agreement
      assert @application.applicationable.completed?
  end

  def test_redirect_to_first_step
    @adopter = build(:adopter)
    @credentials = @adopter.create_token
    @adopter.save
    
    patch adopters_applications_agreements_path,
      params: {},
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)
      
    assert_response :redirect
    assert_redirected_to adopters_applications_personal_info_path
  end

  def test_redirect_to_next_step
    @adopter = build(:adopter, :with_application_home)
    @credentials = @adopter.create_token
    @adopter.save
    
    patch adopters_applications_agreements_path,
      params: {},
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)
      
    assert_response :redirect
    assert_redirected_to adopters_applications_home_path
  end
end
