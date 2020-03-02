Rails.application.config.middleware.use OmniAuth::Builder do
  credentials = Rails.application.credentials

  provider :google_oauth2, credentials.google_client_id, credentials.google_client_secret, skip_jwt: true
  provider :facebook, credentials.facebook_app_id, credentials.facebook_app_secret, callback_url: Rails.application.config_for(:config)[:facebook][:redirect_url]
end
