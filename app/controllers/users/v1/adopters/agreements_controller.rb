# frozen_string_literal: true

class Users::V1::Adopters::AgreementsController < Users::V1::Adopters::BaseController
  before_action :redirect_to_first_application_step, unless: :adopter_profile?
  before_action :redirect_to_next_application_step, unless: :agreements?

  def show
    render json: Users::Adopters::Profile::AgreementsPresenter.new(current_user).response, status: :ok
  end

  def update
    profile = current_user.profile

    if profile.update(profile_params)
      profile.agreements? && profile.continue!
      render json: {profile: {}}, status: :ok
    else
      errors = service.profile.errors.full_messages
      render json: errors, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:home_visit_agreement, :adoption_fee_agreement)
  end
  
  def agreements?
    current_user.profile.completed_state?('agreements')
  end
end
