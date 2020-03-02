require "test_helper"

class Users::V1::OmniauthCallbacksController < ActionDispatch::IntegrationTest
  GOOGLE_AUTH_URL = 'https://accounts.google.com/o/oauth2/auth'
  FACEBOOK_AUTH_URL = 'https://www.facebook.com/v3.0/dialog/oauth'

  def test_can_get_facebook_auth_page
    get "/auth/facebook?resource_class=Adopter"

    follow_redirect!

    assert_includes @response.header['location'], FACEBOOK_AUTH_URL
  end
  
  def test_can_get_google_auth_page
    get '/auth/google_oauth2?resource_class=Adopter'

    assert_includes @response.header['location'], GOOGLE_AUTH_URL
  end
end

