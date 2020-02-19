require "test_helper"

class Users::V1::PetsControllerTest < ActionDispatch::IntegrationTest
  def setup
    login_as_admin
  end

  def test_create_success
    post users_pets_url,
      params: { pet: attributes_for(:pet, name: 'Josh') },
      headers: {'API-VERSION' => '1'}

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('pet')
    assert api_response['pet']['name'], 'Josh'
  end

  def test_create_error
    post users_pets_url,
      params: { pet: attributes_for(:pet, name: '') },
      headers: {'API-VERSION' => '1'}

    api_response = JSON.parse(response.body)

    assert_response :bad_request
    assert api_response.include?('pet')
    assert api_response['pet']['name'], ''
  end

  def test_show_success
    pet = create(:pet, name: 'Josh')

    get users_pet_url(pet),
      headers: {'API-VERSION' => '1'}

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('pet')
    assert api_response['pet']['name'], pet.name
  end

  def test_show_error
    get users_pet_url(id: 2),
      headers: {'API-VERSION' => '1'}

    assert_response :not_found
  end

  def test_update_success
    pet = create(:pet, name: 'Josh')

    put users_pet_url(pet),
      params: { pet: { name: 'Tobby' } },
      headers: {'API-VERSION' => '1'}

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('pet')
    assert api_response['pet']['name'], 'Tobby'
  end

  def test_update_error
    pet = create(:pet, name: 'Josh')

    put users_pet_url(pet),
      params: { pet: { name: '' } },
      headers: {'API-VERSION' => '1'}

    api_response = JSON.parse(response.body)

    assert_response :unprocessable_entity
    assert api_response.include?('pet')
    assert api_response['pet']['name'], pet.name
  end
end
