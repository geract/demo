# require "test_helper"

# class Users::V1::Adopters::Applications::ReferencesControllerTest < ActionDispatch::IntegrationTest
  # def setup
  #   @adopter = build(:adopter, :with_application_references)
  #   @credentials = @adopter.create_token
  #   @adopter.save
  # end

  # def test_update
  #   patch adopters_applications_add_references_path,
  #     params: build(:references_params),
  #     headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

  #   @application = PetApplication.last

  #   assert_response :success
  #   assert @application.completed?
  #   assert @application.references.present?
  #   assert @application.applicationable.completed?
  #   assert_equal @application.references.count, 3
  # end

  # def test_redirect_to_first_step
  #   @adopter = build(:adopter)
  #   @credentials = @adopter.create_token
  #   @adopter.save
    
  #   patch adopters_applications_add_references_path,
  #     params: {},
  #     headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)
      
  #   assert_response :redirect
  #   assert_redirected_to adopters_applications_personal_info_path
  # end

  # def test_redirect_to_next_step
  #   @adopter = build(:adopter, :with_application_home)
  #   @credentials = @adopter.create_token
  #   @adopter.save
    
  #   patch adopters_applications_add_references_path,
  #     params: {},
  #     headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)
      
  #   assert_response :redirect
  #   assert_redirected_to adopters_applications_home_path
  # end
# end
