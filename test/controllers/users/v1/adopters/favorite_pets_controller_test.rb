require "test_helper"

class Users::V1::Adopters::FavoritePetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @adopter = create(:adopter)
    @credentials = @adopter.create_token
    @adopter.save
    @pet = create(:pet, :complete)
  end

  def test_favorite_pet_success
    post adopters_favorite_pets_url,
      params: { id: @pet.id },
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    assert_response :ok
  end

  def test_favorite_pet_error
    @adopter.favorite_pets << @pet
    post adopters_favorite_pets_url,
      params: { id: @pet.id },
      headers: headers_v1(@adopter.uid, @credentials.token, @credentials.client)

    assert_response :unprocessable_entity
  end
end
