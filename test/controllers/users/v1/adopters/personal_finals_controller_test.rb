# require "test_helper"

# class Users::V1::Adopters::Applications::PersonalFinalsControllerTest < ActionDispatch::IntegrationTest
  # def setup
  #   @adopter = build(:adopter, :with_application_personal_final)
  #   @credentials = @adopter.create_token
  #   @adopter.save
  # end

  # def test_show
  #   @adopter = build(:adopter, :with_application_home)
  #   @adopter.application.applicationable.state = 'personal_final'
  #   @adopter.application.veterinarian = build(:veterinarian)
  #   @credentials = @adopter.create_token
  #   @adopter.save

  #   get adopters_applications_personal_final_path,
  #     headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

  #   api_response = JSON.parse(response.body)

  #   assert_response :success
  #   assert_equal api_response, build(:personal_final_params)
  # end

  # def test_update
  #   patch adopters_applications_personal_final_path,
  #     params: build(:personal_final_params),
  #     headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

  #   @application = PetApplication.last

  #   assert_response :success
  #   assert @application.filling?
  #   assert @application.veterinarian.present?
  #   assert @application.veterinarian.address.present?
  #   assert @application.applicationable.home?
  #   assert @application.applicationable.pet_info.personal.present?
  #   assert @application.applicationable.pet_info.animal_history.present?
  #   assert @application.applicationable.pet_info.veterinarian_extra.present?
  # end

  # def test_redirect_to_next_step
  #   @adopter = build(:adopter, :with_application_personal_co_adopter)
  #   @credentials = @adopter.create_token
  #   @adopter.save
    
  #   patch adopters_applications_personal_final_path,
  #     params: {},
  #     headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)
      
  #   assert_response :redirect
  #   assert_redirected_to adopters_applications_personal_co_adopter_path
  # end
  
  # def test_redirect_to_first_step
  #   @adopter = build(:adopter)
  #   @credentials = @adopter.create_token
  #   @adopter.save
    
  #   patch adopters_applications_personal_final_path,
  #     params: {},
  #     headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)
      
  #   assert_response :redirect
  #   assert_redirected_to adopters_applications_personal_info_path
  # end
# end
