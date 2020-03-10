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
    assert_equal 'https://s3.amazonaws.com/filestore.rescuegroups.org/13/pictures/animals/0/320/181_350x216.jpg', api_response['pets'][0]['image']
  end

  def test_show
    api_key = Rails.application.credentials.rescue_groups_key

    stub_request(:post, "https://api.rescuegroups.org/http/json").
          with(
             body: "{\"objectAction\":\"publicView\",\"objectType\":\"orgs\",\"fields\":[\"orgAbout\",\"orgAdoptionProcess\",\"orgAdoptionUrl\",\"orgCommonapplicationAccept\",\"orgDonationUrl\",\"orgEmail\",\"orgFacebookUrl\",\"orgFax\",\"orgID\",\"orgLocation\",\"orgAddress\",\"orgCity\",\"orgCountry\",\"orgLocationDistance\",\"orgPostalcode\",\"orgState\",\"orgPlus4\",\"orgMeetPets\",\"orgName\",\"orgPhone\",\"orgServeAreas\",\"orgServices\",\"orgSponsorshipUrl\",\"orgType\",\"orgWebsiteUrl\"],\"values\":[{\"orgID\":13}],\"apikey\":\"#{api_key}\"}").
          to_return(status: 200, body: { data: [build(:rescue_groups_organization_response)] }.to_json)

    stub_request(:post, 'https://api.rescuegroups.org/http/json').
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
    assert_equal 'https://s3.amazonaws.com/filestore.rescuegroups.org/13/pictures/animals/0/320/181_350x216.jpg', api_response['pet']['image']
  end
end

