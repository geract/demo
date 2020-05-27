require "test_helper"

class Users::V1::Rescuers::PetApplications::ProfilesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = build(:rescuer_admin, :complete)
    @credentials = @user.create_token
    @user.save
  end
  
  def test_show_success
    @organization = @user.profile.organization
    @pet_application = create(:pet_application, organization: @organization)

    get rescuers_pet_application_profiles_path(@pet_application),
      params: {},
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert api_response['id'].present?
    assert api_response['email'].present?
    assert api_response['address_attributes'].present?
    assert api_response['employment_attributes'].present?
    assert api_response['employment_attributes']['address_attributes'].present?
    assert api_response['references'].any?
    assert api_response['references'][0]['first_name'].present?
    assert_equal api_response['pronoun'], 'She'
    assert_equal api_response['address_attributes']['city'], 'Mountain View'
    assert_equal api_response['employment_attributes']['company'], 'PetParent'
    assert_equal api_response['employment_attributes']['address_attributes']['state'], 'CA'
    assert_nil api_response['preferences']['age']
    assert_equal api_response['references'][0]['first_name'], 'Juanito'
  end
end
