require "test_helper"

class Users::V1::Rescuers::PetApplicationControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = build(:rescuer_admin, :complete)
    @organization = @user.profile.organization
    @credentials = @user.create_token
    @user.save
  end

  def test_index_success
    pet1 = create(:pet, organization: @organization, name: 'Pet1', added_by: @user)
    create(:pet_application, pet: pet1, organization: pet1.organization)
    pet2 = create(:pet, organization: @organization, name: 'Pet2', added_by: @user)
    create(:pet_application, pet: pet2, organization: pet2.organization)

    get rescuers_pet_applications_path, headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('applications')
    assert api_response['applications'].size >= 2
    assert_equal 'Pet1', api_response['applications'][0]['pet']['name']
    assert api_response['applications'][0]['date_listed'].present?
    assert api_response['applications'][0]['total_applications'].present?
  end

  def test_index_with_filter
    pet2 = create(:pet, organization: @organization, name: 'Pet2', added_by: @user)
    create(:pet_application, pet: pet2, organization: pet2.organization)

    get rescuers_pet_applications_path,
      params: { filters: {status: 'created'} },
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response.include?('applications')
    assert_equal 'Pet2', api_response['applications'][0]['pet']['name']
    assert_equal 1, api_response['applications'].size
    assert api_response['applications'][0]['date_listed'].present?
    assert api_response['applications'][0]['total_applications'].present?
  end
end
