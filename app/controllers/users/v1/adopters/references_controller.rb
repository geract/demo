# frozen_string_literal: true

class Users::V1::Adopters::ReferencesController < Users::V1::Adopters::BaseController
  before_action :redirect_to_profile_step, unless: -> { current_user.profile.completed_status?('add_references') }

  def show
    render json: Users::Adopters::Profile::ReferencesPresenter.new(current_user), status: :ok
  end

  def update
    profile = current_user.profile

    if Adopter::Profile::SaveReferencesService.perform(profile, adopter_profile_params)
      head :ok
    else
      render json: profile.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def adopter_profile_params
    params.require(:profile).permit(:id,
      references_attributes: %i[id first_name last_name email phone_number relationship]
    )
  end
end

