# frozen_string_literal: true

class Users::V1::Adopters::ReferencesController < Users::V1::Adopters::BaseController
  before_action :redirect_to_first_profile_step, unless: :adopter_profile?
  before_action :redirect_to_next_profile_step, unless: :references?

  def show
    render json: Users::Adopters::Profile::ReferencesPresenter.new(current_user), status: :ok
  end

  def update
    adopter = Adopter::Profile::SaveReferences.new(current_user, adopter_profile_params)
    if adopter.perform
      render json: {profile: {}}, status: :ok
    else
      errors = adopter.profile.errors.full_messages
      render json: errors, status: :unprocessable_entity
    end
  end

  private

  def adopter_profile_params
    params.require(:profile).permit(
      references_attributes: %i[id first_name last_name email phone_number relationship]
    )
  end

  def references?
    current_user.profile.completed_state?('add_references')
  end
end

