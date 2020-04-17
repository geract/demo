require "test_helper"

class Users::V1::PetsControllerTest < ActionDispatch::IntegrationTest
  def setup
  end

  def test_index
    stub_request(:post, 'https://api.rescuegroups.org/http/json').
      to_return(status: 200, body: { data: build(:rescue_groups_response) }.to_json)

    get pets_url,
      headers: headers_v1

    api_response = JSON.parse(response.body)

    assert_response :success
    assert_equal '320', api_response['pets'][0]['id']
    assert_equal 'Corky', api_response['pets'][0]['name']
    assert_equal 'Male', api_response['pets'][0]['sex']
    assert_equal 'Domestic Short Hair', api_response['pets'][0]['breed']
    assert_equal 'Young', api_response['pets'][0]['age']
    assert_equal 'Bowie, MD', api_response['pets'][0]['location']
    assert_equal 'Small', api_response['pets'][0]['size']
    assert_equal 'https://s3.amazonaws.com/filestore.rescuegroups.org/13/pictures/animals/0/320/181_350x216.jpg', api_response['pets'][0]['images'][0]['original']
  end

  def test_show
    api_key = Rails.application.credentials.rescue_groups_key

    stub_request(:post, "https://api.rescuegroups.org/http/json").
      with(body: hash_including('objectType': 'orgs')).
      to_return(status: 200, body: { data: [build(:rescue_groups_organization_response)] }.to_json)

    stub_request(:post, 'https://api.rescuegroups.org/http/json').
      with(body: hash_including('objectType': 'animals')).
      to_return(status: 200, body: { data: build(:rescue_groups_response) }.to_json)

    get pet_url(id: '320'),
      headers: headers_v1

    api_response = JSON.parse(response.body)

    assert_response :success
    assert_equal '320', api_response['pet']['id']
    assert_equal 'Corky', api_response['pet']['name']
    assert_equal 'Male', api_response['pet']['sex']
    assert_equal 'Domestic Short Hair', api_response['pet']['breed']
    assert_equal 'Young', api_response['pet']['age']
    assert_equal 'Bowie, MD', api_response['pet']['location']
    assert_equal 'https://s3.amazonaws.com/filestore.rescuegroups.org/13/pictures/animals/0/320/181_350x216.jpg', api_response['pet']['images'][0]['original']
    assert_equal 'Adopted', api_response['pet']['status']
    assert_equal '', api_response['pet']['birthdate']
    assert_equal '13.00', api_response['pet']['fee']
    assert_equal 'description', api_response['pet']['description']
    assert_equal '13', api_response['pet']['organization_id']
    assert_equal 'Small', api_response['pet']['size']
    assert_equal 'Animal Relief Fund', api_response['pet']['organization_name']
  end
end

