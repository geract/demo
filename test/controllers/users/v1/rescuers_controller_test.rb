require 'test_helper'

class Users::V1::RescuersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:rescuer_admin)
    @credentials = @user.create_token
    @user.save
    @rescuer = create(:rescuer, first_name: 'Peter', last_name: 'Dee')
  end

  def test_rescuer_admin_create_success
    post users_rescuers_url,
      params: {
        rescuer: {
          first_name: 'Joane',
          last_name: 'Doe',
          phone: '888999222',
          email: 'joane@doe.com'
        }
      },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('rescuer')
    assert api_response['rescuer']['first_name'], 'Joane'
    assert api_response['rescuer']['last_name'], 'Doe'
    assert api_response['rescuer']['phone'], '888999222'
    assert api_response['rescuer']['email'], 'joane@doe.com'
  end

  def test_rescuer_admin_update
    patch users_rescuer_url(@rescuer),
      params: {
        rescuer: {
          first_name: 'Michael',
          last_name: 'Doe',
          phone: '888999222',
          email: 'joane@doe.com'
        }
      },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('rescuer')
    assert api_response['rescuer']['first_name'], 'Michael'
    assert api_response['rescuer']['last_name'], 'Doe'
    assert api_response['rescuer']['phone'], '888999222'
    assert api_response['rescuer']['email'], 'joane@doe.com'
  end

  def test_rescuer_admin_show
    get users_rescuer_url(@rescuer),
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('rescuer')
    assert api_response['rescuer']['first_name'], 'Peter'
    assert api_response['rescuer']['last_name'], 'Dee'
    assert api_response['rescuer']['phone'], '888999222'
    assert api_response['rescuer']['email'], 'joane@doe.com'
  end
end
