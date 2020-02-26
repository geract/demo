require "test_helper"

class Users::V1::PetBulksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:rescuer_admin)
    @credentials = @user.create_token
    @user.save
  end

  def test_can_update_several_pets_at_once
    create(:pet, name: 'GoodBoy17')
    create(:pet, name: 'Doge')

    put users_pet_bulk_path,
      params: { pets: Pet.ids, status: 'publish' },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('pets')
    assert_equal 'GoodBoy17', api_response['pets'].first['name']
    assert_equal 'Doge', api_response['pets'].last['name']
  end

  def test_failed_update
    create(:pet, name: 'GoodBoy17', reason_code: nil)
    create(:pet, name: 'Doge', reason_code: nil)
    
    put users_pet_bulk_path,
      params: { pets: Pet.ids, status: 'archive' },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :unprocessable_entity
    assert api_response.include?('pets')
    assert api_response.include?('errors')
    assert_equal api_response['errors'].first['errors'], {"reason_code"=>["Reason code is required when trying to archive a pet"]}
  end

  def test_failed_update_due_pets_param_missing
    put users_pet_bulk_path,
      params: { pets: [], status: 'publish' },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :ok
    api_response.include?('pets')
    assert api_response['pets'].empty?
    assert api_response['errors'].empty?
  end
end
