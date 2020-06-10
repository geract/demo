require "test_helper"

class Users::V1::Rescuers::PetBulksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:rescuer_admin, :complete)
    @credentials = @user.create_token
    @user.save
    @organization = create(:organization, :complete, rescuer_admin_profile: @user.profile)
  end

  def test_can_update_several_pets_at_once
    create(:pet, :complete, name: 'GoodBoy17', organization: @organization, added_by: @user)
    create(:pet, :complete, name: 'Doge', organization: @organization, added_by: @user)

    put rescuers_pet_bulk_path,
      params: { pets: Pet.ids, status: 'publish' },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    assert_response :success
  end

  def test_failed_update
    create(:pet, :complete, name: 'GoodBoy17', reason_code: nil, organization: @organization)
    create(:pet, :complete, name: 'Doge', reason_code: nil, organization: @organization)
    
    put rescuers_pet_bulk_path,
      params: { pets: Pet.ids, status: 'archive' },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :unprocessable_entity
    assert api_response.include?('errors')
    assert_equal api_response['errors'].first['errors'], {"reason_code"=>["Reason code is required when trying to archive a pet"]}
  end

  def test_failed_update_due_pets_param_missing
    put rescuers_pet_bulk_path,
      params: { pets: [], status: 'publish' },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :ok
    assert api_response['errors'].empty?
  end
end
