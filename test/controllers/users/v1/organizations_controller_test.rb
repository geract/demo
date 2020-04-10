require "test_helper"

class Users::V1::OrganizationsControllerTest < ActionDispatch::IntegrationTest
  def setup
  end

  def test_show
    api_key = Rails.application.credentials.rescue_groups_key

    stub_request(:post, "https://api.rescuegroups.org/http/json").
          with(body: hash_including('objectType': 'orgs')).
          to_return(status: 200, body: { data: [build(:rescue_groups_organization_response)] }.to_json)

    stub_request(:post, "https://api.rescuegroups.org/http/json").
          with(body: hash_including('objectType': 'animals')).
          to_return(status: 200, body: { data: build(:rescue_groups_response) }.to_json)

    get organization_url(id: '16'),
      headers: headers_v1

    api_response = JSON.parse(response.body)

    assert_response :success
    
    assert_equal '16', api_response['organization']['id']
    assert_equal 'Animal Relief Fund', api_response['organization']['name']
    assert_equal 'description', api_response['organization']['description']
    assert_equal 'webUrl', api_response['organization']['webUrl']
    assert_equal 'info@animalrelieffund.org', api_response['organization']['email']
    assert_equal '20636', api_response['organization']['code']
    assert_equal 'P.O. Box 184, Hollywood, United States', api_response['organization']['address']
    assert_equal '320', api_response['organization']['pets'][0]['id']
    assert_equal 'Corky', api_response['organization']['pets'][0]['name']
    assert_equal 'Male', api_response['organization']['pets'][0]['sex']
    assert_equal 'Domestic Short Hair', api_response['organization']['pets'][0]['breed']
    assert_equal 'Young', api_response['organization']['pets'][0]['age']
    assert_equal 'Bowie, MD', api_response['organization']['pets'][0]['location']
    assert_equal 'https://s3.amazonaws.com/filestore.rescuegroups.org/13/pictures/animals/0/320/181_350x216.jpg', api_response['organization']['pets'][0]['image']
  end
end
