require "test_helper"

class Users::V1::Rescuers::PetsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = build(:rescuer_admin, :complete)
    @credentials = @user.create_token
    @user.save
    @organization = create(:organization, :complete, rescuer_admin_profile: @user.profile)
  end

  def test_create_success
    post users_rescuers_pets_url,
      params: { pet: attributes_for(:pet, name: 'Josh') },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)
    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('pet')
    assert api_response['pet']['name'], 'Josh'
  end

  def test_create_error
    post users_rescuers_pets_url,
      params: { pet: attributes_for(:pet, name: '') },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :bad_request
    assert api_response.include?('pet')
    assert api_response['pet']['name'], ''
  end

  def test_show_success
    pet = create(:pet, :complete, name: 'Josh', organization: @organization)

    get users_rescuers_pet_url(pet),
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('pet')
    assert api_response['pet']['name'], pet.name
  end
  
  def test_show_no_pet_error
    get users_rescuers_pet_url(id: 'pikachu'),
    headers: headers_v1(@user.uid, @credentials.token, @credentials.client)
    
    assert_response :not_found
  end

  def test_update_success
    pet = create(:pet, :complete, name: 'Josh', organization: @organization)

    put users_rescuers_pet_url(pet),
      params: { pet: { name: 'Tobby' } },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('pet')
    assert api_response['pet']['name'], 'Tobby'
  end

  def test_update_error
    pet = create(:pet, :complete, name: 'Josh', organization: @organization)

    put users_rescuers_pet_url(pet),
      params: { pet: { name: '' } },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :unprocessable_entity
    assert api_response.include?('pet')
    assert api_response['pet']['name'], pet.name
  end
  
  def test_index
    published_pet = create(:pet, :complete, name: 'Pancho', status: 'published', organization: @organization)
    archived_pet = create(:pet, :complete, name: 'Archi', status: 'archived', reason_code: 'pet_died', organization: @organization)
    adopted_pet = create(:pet, :complete, name: 'Aldo', status: 'adopted', organization: @organization)
    
    get users_rescuers_pets_url,
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)
    
    api_response = JSON.parse(response.body)['pets']
 
    assert_response :success
    assert api_response[0]['name'], published_pet.name
    assert api_response[1]['name'], archived_pet.name
    assert api_response[2]['name'], adopted_pet.name
  end
end