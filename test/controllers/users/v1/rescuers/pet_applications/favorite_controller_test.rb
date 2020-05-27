require "test_helper"

class Users::V1::Rescuers::Pets::FavoritesApplicationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = build(:rescuer_admin, :complete)
    @credentials = @user.create_token
    @user.save
    
    @organization = @user.profile.organization
    @pet = create(:pet, organization: @organization, name: 'Pet1', added_by: @user)
    @pet_application = create(:pet_application, pet: @pet, organization: @organization)
  end

  def test_create_success
    post rescuers_pet_application_favorites_path(@pet_application.id),
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    assert_response :success
  end

  def test_delete_success
    delete rescuers_pet_application_favorites_path(@pet_application.id),
      headers: headers_v1(@user.uid, @credentials.token, @credentials.client)

    assert_response :success
  end
end
