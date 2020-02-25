require "test_helper"

class Users::V1::PetsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:rescuer_admin)
    @credentials = @user.create_token
    @user.save
  end

  def test_create_success
    post users_pets_url,
      params: { pet: attributes_for(:pet, name: 'Josh') },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('pet')
    assert api_response['pet']['name'], 'Josh'
  end

  def test_create_error
    post users_pets_url,
      params: { pet: attributes_for(:pet, name: '') },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :bad_request
    assert api_response.include?('pet')
    assert api_response['pet']['name'], ''
  end

  def test_show_success
    pet = create(:pet, name: 'Josh')

    get users_pet_url(pet),
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('pet')
    assert api_response['pet']['name'], pet.name
  end

  def test_show_archived_pet_error
    pet = create(:pet, status: 'archived', reason_code: 'pet_died')
    
    get users_pet_url(pet),
    headers: headers_v1(@user.uid, @credentials.token, @credentials.client)
    
    api_response = JSON.parse(response.body)
    
    assert_response :gone
    assert api_response.include?('errors')
    assert_includes api_response['errors'].first, 'Doggo is no longer available. Look for more pets like Doggo'
  end
  
  def test_show_no_pet_error
    get users_pet_url(id: 'pikachu'),
    headers: headers_v1(@user.uid, @credentials.token, @credentials.client)
    
    assert_response :not_found
  end

  def test_update_success
    pet = create(:pet, name: 'Josh')

    put users_pet_url(pet),
      params: { pet: { name: 'Tobby' } },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('pet')
    assert api_response['pet']['name'], 'Tobby'
  end

  def test_update_error
    pet = create(:pet, name: 'Josh')

    put users_pet_url(pet),
      params: { pet: { name: '' } },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :unprocessable_entity
    assert api_response.include?('pet')
    assert api_response['pet']['name'], pet.name
  end
  
  def test_index
    published_pet = create(:pet, name: 'Pancho', status: 'published')
    archived_pet = create(:pet, name: 'Archi', status: 'archived', reason_code: 'pet_died')
    adopted_pet = create(:pet, name: 'Aldo', status: 'adopted')
    
    get users_pets_url,
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)
    
    api_response = JSON.parse(response.body)['pets']
 
    assert_response :success
    assert api_response[0]['name'], published_pet.name
    assert api_response[1]['name'], archived_pet.name
    assert api_response[2]['name'], adopted_pet.name
  end
end
