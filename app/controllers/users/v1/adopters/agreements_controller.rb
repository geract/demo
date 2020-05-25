# frozen_string_literal: true

class Users::V1::Adopters::AgreementsController < Users::V1::Adopters::BaseController
  before_action :redirect_to_profile_step, unless: -> { current_user.profile.completed_status?('agreements') }

  def show
    render_with_presenter
  end

  def update
    profile = current_user.profile

    if profile.update(profile_params)
      profile.continue! if profile.agreements?
      head :ok
    else
      render json: profile.errors.full_message, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:home_visit_agreement, :adoption_fee_agreement)
  end
end
