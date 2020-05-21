require "test_helper"

class Users::V1::Rescuers::PetApplicationsStatusesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:rescuer_admin, :complete)
    @credentials = @user.create_token
    @user.save

    @organization = create(:organization, :complete, rescuer_admin_profile: @user.profile)
    @pet = create(:pet, organization: @organization, name: 'Boomer', added_by: @user)
    @pet_application = create(:pet_application, pet: @pet, organization: @organization)
  end

  def test_update_success
    put rescuers_pet_applications_status_path(@pet_application),
      params: {
        pet_application: {
          status: 'reject',
          rejection_details: {
            "question_1": {
              "text": "Are you denying the applicant based on the needs of the dog or rescue?",
              "answer": "Dog"
            }
          }
        }
      },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    assert_response :success
  end

  def test_update_error
    put rescuers_pet_applications_status_path(@pet_application),
      params: {
        pet_application: {
          status: 'reject',
          rejection_details: ""
        }
      },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    assert_response :unprocessable_entity
  end
end
