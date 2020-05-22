require "test_helper"

class Users::V1::Adopters::Pets::FavoritesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @adopter = create(:adopter)
    @credentials = @adopter.create_token
    @adopter.save
    @pet = create(:pet, :complete)
  end

  def test_index
    create(:favorite_pet, pet: @pet, adopter: @adopter)

    get adopters_favorites_url,
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response
    assert_equal @pet.id, api_response[0]['id']
  end

  def test_create
    stub_request(:post, 'https://api.rescuegroups.org/http/json').
      to_return(status: 200, body: { data: [] }.to_json)

    post adopters_pet_favorites_url(@pet),
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    assert_response :ok
  end

  def test_delete
    create(:favorite_pet, pet: @pet, adopter: @adopter)

    delete adopters_pet_favorites_url(@pet),
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    assert_response :ok
  end
end

