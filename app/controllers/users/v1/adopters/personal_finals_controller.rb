# frozen_string_literal: true

class Users::V1::Adopters::PersonalFinalsController < Users::V1::Adopters::BaseController
  before_action :redirect_to_first_profile_step, unless: :adopter_profile?
  before_action :redirect_to_next_profile_step, unless: :personal_final?

  def show
    render json: Users::Adopters::Profile::PersonalFinalPresenter.new(current_user), status: :ok
  end

  def update
    adopter = Adopter::Profile::SavePersonalFinal.new(current_user, adopter_profile_params)
    if adopter.perform
      render json: {application: {}}, status: :ok
    else
      errors = adopter.profile.errors.full_messages
      render json: errors, status: :unprocessable_entity
    end
  end

  private

  def adopter_profile_params
    params.require(:profile).permit(:id,
      pet_info_attributes: [
        personal: %i[has_children children_ages is_pet_allergic pet_allergic_plan],
        animal_history: %i[has_pets pet_name pet_species pet_breed pet_sex pet_age
                            has_owned_pets owned_pet_name owned_pet_species owned_pet_breed
                            owned_pet_sex owned_pet_age],
        veterinarian_extra: %i[is_contactable emergency_vet_bills_plan is_pet_insurance has_veterinarian]],
      veterinarian_attributes: [:id, :first_name, :last_name, :email, :phone_number,
        address_attributes: %i[id street_line_1 street_line_2 city state country zip_code]])
  end

  def personal_final?
    current_user.profile.completed_state?('personal_final')
  end
end
