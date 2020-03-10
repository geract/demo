class Users::V1::Adopters::BaseController < Users::V1::BaseController
  before_action :authenticate_adopter!

  def authenticate_adopter!
    return if current_user.class == Adopter

    render_error(401, I18n.t('devise_token_auth.sessions.bad_credentials'))
  end
end
