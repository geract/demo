class Users::V1::Adopters::BaseController < Users::V1::BaseController
  before_action :authenticate_adopter!

  def authenticate_adopter!
    return if current_user.class == Adopter

    render_error(401, I18n.t('devise_token_auth.sessions.bad_credentials'))
  end

  private

  # TODO check usage

  def adopter_application?
    !!current_user.application
  end

  def next_application_step
    return [:adopters_applications, current_user.application.state] if current_user.application.completed?
    [:adopters_applications, current_user.application.applicationable.state]
  end

  def redirect_to_first_application_step
    redirect_to %i[adopters_applications personal_info]
  end

  def redirect_to_next_application_step
    redirect_to next_application_step
  end
end
