require "test_helper"

class Users::V1::Rescuers::ProfilesControllerTest < ActionDispatch::IntegrationTest
  def setup
    user = create(:rescuer_admin, :complete)
    organization = create(:organization, :complete, rescuer_admin_profile: user.profile)
    @rescuer_profile = create(:rescuer_profile, :complete, organization: organization)
    @rescuer = @rescuer_profile.rescuer
    @credentials = @rescuer.create_token
    @rescuer.save
  end

  def test_rescuer_update_success
    refute @rescuer.profile.photo.attached?

    patch rescuers_profile_url,
      params: {
        rescuer: {
          first_name: 'Joane',
          last_name: 'Doe',
          phone: '888999222',
          email: 'joane@doe.com',
          title: 'veterinarian',
          photo: fixture_file_upload("files/test_attachment.jpg", "image/jpg")
        }
      },
      headers: headers_v1(@rescuer.uid, @credentials.token, @credentials.client)

    assert_response :success
  end

  def test_rescuer_update_password_success
    patch rescuers_profile_url,
      params: {
        rescuer: {
          first_name: 'Joane',
          last_name: 'Doe',
          phone: '888999222',
          title: 'veterinarian',
          email: 'joane@doe.com',
          password: 'iFyRAB53n',
          password_confirmation: 'iFyRAB53n'
        }
      },
      headers: headers_v1(@rescuer.uid, @credentials.token, @credentials.client)

    assert_response :success
  end

  def test_rescuer_show
    get rescuers_profile_url,
      headers: headers_v1(@rescuer.uid, @credentials.token, @credentials.client)

    api_response = JSON.parse(response.body)

    assert_response :success
    assert_equal api_response['first_name'], @rescuer_profile.first_name
    assert_equal api_response['last_name'], @rescuer_profile.last_name
    assert_equal api_response['phone'], @rescuer_profile.phone
    assert_equal api_response['email'], @rescuer.email
    assert_equal api_response['title'], @rescuer_profile.title
    assert_equal api_response['photo'], ''
  end
end
