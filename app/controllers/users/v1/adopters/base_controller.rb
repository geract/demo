class Users::V1::Adopters::BaseController < Users::V1::BaseController
  before_action :authenticate_adopter!

  def authenticate_adopter!
    return if current_user.class == Adopter

    render_error(401, I18n.t('devise_token_auth.sessions.bad_credentials'))
  end

  private

  def adopter_profile?
    !!current_user.profile.pet_info
  end

  def next_profile_step
    [:adopters, current_user.profile.state]
  end

  def redirect_to_first_profile_step
    redirect_to %i[adopters personal_info]
  end

  def redirect_to_next_profile_step
    redirect_to next_profile_step
  end
end
