require 'test_helper'

class Users::V1::Rescuers::RescuersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:rescuer_admin, :complete)
    @organization = create(:organization, :complete, rescuer_admin_profile: @user.profile)
    @credentials = @user.create_token
    @user.save
    rescuer_profile = create(:rescuer_profile, :complete, organization: @organization)
    @rescuer = rescuer_profile.rescuer
  end

  def test_rescuer_admin_create_success
    post rescuers_rescuers_url,
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
    assert_equal api_response['rescuer']['first_name'], 'Joane'
    assert_equal api_response['rescuer']['last_name'], 'Doe'
    assert_equal api_response['rescuer']['phone'], '888999222'
    assert_equal api_response['rescuer']['email'], 'joane@doe.com'
  end

  def test_rescuer_admin_update
    patch rescuers_rescuer_url(@rescuer),
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
    assert_equal api_response['rescuer']['first_name'], 'Michael'
    assert_equal api_response['rescuer']['last_name'], 'Doe'
    assert_equal api_response['rescuer']['phone'], '888999222'
    assert_equal api_response['rescuer']['email'], 'joane@doe.com'
  end

  def test_rescuer_admin_show
    get rescuers_rescuer_url(@rescuer),
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('rescuer')
    assert_equal api_response['rescuer']['first_name'], 'Juan'
    assert_equal api_response['rescuer']['last_name'], 'Rescuer'
    assert_equal api_response['rescuer']['phone'], '888999222'
  end

  def test_rescuer_admin_index_activated_status
    create(:rescuer, :complete, status: 'activated', profile: build(:rescuer_profile, first_name: 'Albert', organization: @organization))
    create(:rescuer, :complete, status: 'archived', profile: build(:rescuer_profile, first_name: 'Claudia', organization: @organization))
    create(:rescuer, :complete, status: 'activated', profile: build(:rescuer_profile, first_name: 'Xavier', organization: @organization))

    get rescuers_rescuers_url, params: { status: 'activated' },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert_equal api_response['rescuers'].size, 2
    assert_equal api_response['rescuers'][0]['first_name'], 'Albert'
    assert_equal api_response['rescuers'][1]['first_name'], 'Xavier'
  end

  def test_rescuer_admin_index_empty_status
    create(:rescuer, :complete, status: 'activated', profile: build(:rescuer_profile, first_name: 'Albert', organization: @organization))
    create(:rescuer, :complete, status: 'archived', profile: build(:rescuer_profile, first_name: 'Claudia', organization: @organization))
    create(:rescuer, :complete, status: 'activated', profile: build(:rescuer_profile, first_name: 'Xavier', organization: @organization))

    get rescuers_rescuers_url, params: { status: '' },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert_equal api_response['rescuers'].size, 0
  end
end
