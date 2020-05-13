require 'test_helper'

class Users::V1::Adopters::MessagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:adopter)
    @organization = create(:organization, :complete)
    @credentials = @user.create_token
    @user.save
    @pet = create(:pet, :complete, organization: @organization)
  end

  def test_rescuer_adopter_create_success
    skip
    post adopters_messages_url,
      params: {
        message: {
          message: 'Hello',
          pet_id: @pet.id,
          organization_id: @organization.id
        }
      },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('message')
    assert_equal api_response['message']['message'], 'Hello'
    assert_equal api_response['message']['pet_id'], @pet.id
  end

  def test_rescuer_adopter_index
    skip
    create_list(:message, 3, organization: @organization, sender: @user)

    get adopters_messages_url,
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert_equal api_response['messages'].size, 3
  end
end
