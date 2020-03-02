class Users::V1::Rescuers::BaseController < Users::V1::BaseController
  before_action :authenticate_rescuer!

  def authenticate_rescuer!
    return if current_user.class == RescuerAdmin || current_user.class == Rescuer
    render_error(401, I18n.t('devise_token_auth.sessions.bad_credentials'))
  end
end