# require "test_helper"

# class Users::V1::Adopters::Applications::HomesControllerTest < ActionDispatch::IntegrationTest
  # def setup
  #   @adopter = build(:adopter, :with_application_home)
  #   @credentials = @adopter.create_token
  #   @adopter.save
  # end

  # def test_show
  #   @adopter = build(:adopter, :with_application_lifestyle)
  #   @adopter.application.applicationable.state = 'home'
  #   @credentials = @adopter.create_token
  #   @adopter.save

  #   get adopters_applications_home_path,
  #     headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

  #   api_response = JSON.parse(response.body)

  #   assert_response :success
  #   assert_equal api_response, build(:application_home_params)
  # end

  # def test_update
  #   patch adopters_applications_home_path,
  #     params: build(:application_home_params),
  #     headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

  #   @application = PetApplication.last

  #   assert_response :success
  #   assert @application.filling?
  #   assert @application.applicationable.lifestyle?
  #   assert @application.applicationable.pet_info.home.present?
  # end
  
  # def test_redirect_to_first_step
  #   @adopter = build(:adopter)
  #   @credentials = @adopter.create_token
  #   @adopter.save

  #   patch adopters_applications_home_path,
  #     params: {},
  #     headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

  #   assert_response :redirect
  #   assert_redirected_to adopters_applications_personal_info_path
  # end

  # def test_redirect_to_next_step
  #   @adopter = build(:adopter, :with_application_personal_final)
  #   @credentials = @adopter.create_token
  #   @adopter.save
    
  #   patch adopters_applications_home_path,
  #     params: {},
  #     headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)
      
  #   assert_response :redirect
  #   assert_redirected_to adopters_applications_personal_final_path
  # end
# end
