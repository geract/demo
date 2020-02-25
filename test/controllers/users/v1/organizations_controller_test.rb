require "test_helper"

class Users::V1::OrganizationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:rescuer_admin)
    @credentials = @user.create_token
    @user.save
    @organization = create(:organization, :complete,
                           name: 'Happy tails',
                           email: 'happytails@pph.com',
                           '5013c': 'random number')
  end

  def test_rescuer_admin_update_success
    put users_organization_url(@organization),
      params: { organization: { name: 'happy paws' } },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('organization')
    assert api_response['organization']['name'], 'happy paws'
    assert api_response['organization']['legal_address']
    assert api_response['organization']['physical_addresses']
  end

  def test_rescuer_admin_cannot_update_email
    put users_organization_url(@organization),
      params: { organization: { email: 'happy@paws.com' } },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('organization')
    assert api_response['organization']['email'], 'happytails@pph.com'
    assert api_response['organization']['legal_address']
    assert api_response['organization']['physical_addresses']
  end

  def test_rescuer_admin_cannot_update_5013
    put users_organization_url(@organization),
      params: { organization: { '5013': 'this is a test' } },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('organization')
    assert api_response['organization']['n5013c'], 'random number'
  end

  def test_rescuer_admin_required_director
    put users_organization_url(@organization),
      params: { organization: { name: ' ' } },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :unprocessable_entity
    assert api_response.include?('errors')
    assert api_response['errors'], "Director can't be blank"
  end

  def test_rescuer_admin_required_phone
    put users_organization_url(@organization),
      params: { organization: { phone: ' ' } },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :unprocessable_entity
    assert api_response.include?('errors')
    assert api_response['errors'], "Phone can't be blank"
  end

  def test_rescuer_admin_required_name
    put users_organization_url(@organization),
      params: { organization: { name: ' ' } },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :unprocessable_entity
    assert api_response.include?('errors')
    assert api_response['errors'], "Name can't be blank"
  end

  def test_user_cannot_update
    user = create(:user)
    credentials = user.create_token
    user.save

    put users_organization_url(@organization),
      params: { organization: { 'name': 'happy tails' } },
      headers: headers_v1(user.uid, credentials.token, credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :forbidden
  end

  def test_rescuer_admin_show
    get users_organization_url(@organization),
      params: { organization: { 'name': 'happy tails' } },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('organization')
    assert api_response['organization']['name'], 'Happy tails'
    assert api_response['organization']['legal_address']
    assert api_response['organization']['physical_addresses']
  end

  def test_user_show
    user = create(:user)
    credentials = user.create_token
    user.save

    get users_organization_url(@organization),
      headers: headers_v1(user.uid, credentials.token, credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :forbidden
  end
end
