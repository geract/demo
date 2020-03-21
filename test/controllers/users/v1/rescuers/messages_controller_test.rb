require 'test_helper'

class Users::V1::Rescuers::MessagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:rescuer_admin, :complete)
    @organization = create(:organization, :complete, rescuer_admin_profile: @user.profile)
    @credentials = @user.create_token
    @user.save
    @pet = create(:pet, organization: @organization, added_by: @user)
  end

  def test_rescuer_admin_create_success
    post rescuers_messages_url,
      params: {
        message: {
          message: 'Hello',
          pet_id: @pet.id
        }
      },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('message')
    assert_equal api_response['message']['message'], 'Hello'
    assert_equal api_response['message']['pet_id'], @pet.id
  end

  def test_rescuer_admin_index
    create_list(:message, 3, organization: @organization, sender: @user)

    get rescuers_messages_url,
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert_equal api_response['messages'].size, 3
  end
end
