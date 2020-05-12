require 'test_helper'

class Users::V1::Rescuers::MessagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    admin = build(:rescuer_admin, :complete)
    organization = admin.profile.organization
    @user = create(:rescuer, :complete, status: 'activated', profile: build(:rescuer_profile, first_name: 'Bruce', organization: organization))
    pet = create(:pet, organization: organization, name: 'Boomer', added_by: admin)
    @pet_application = create(:pet_application, pet: pet, organization: pet.organization)
    @credentials = @user.create_token
    @user.save
  end

  def test_rescuer_create_success
    post rescuers_pet_application_messages_path(@pet_application.id),
      params: {
        message: {
          message: 'Hello',
          pet_application_id: @pet_application.id
        }
      },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    assert_response :success
  end

  def test_rescuer_index
    create_list(:message,
                3,
                pet_application: @pet_application,
                senderable: @user)

    get rescuers_pet_application_messages_path(@pet_application.id),
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert_equal api_response['messages'].size, 3
  end
end
