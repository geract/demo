# frozen_string_literal: true

class Users::V1::Adopters::PersonalFinalsController < Users::V1::Adopters::BaseController
  before_action :redirect_to_profile_step, unless: -> { current_user.profile.completed_status?('personal_final') }

  def show
    response_with_presenter
  end

  def update
    profile = current_user.profile
    profile.build_veterinarian unless profile.veterinarian

    if Adopter::Profile::SavePersonalFinalService.perform(profile, adopter_profile_params)
      head :ok
    else
      render json: profile.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def adopter_profile_params
    params.require(:profile).permit(:id,
      pet_info_attributes: [ :id,
        personal: %i[has_children children_ages is_pet_allergic pet_allergic_plan],
        animal_history: %i[has_pets pet_name pet_species pet_breed pet_sex pet_age
                            has_owned_pets owned_pet_name owned_pet_species owned_pet_breed
                            owned_pet_sex owned_pet_age owned_pet_where],
        veterinarian_extra: %i[is_contactable emergency_vet_bills_plan is_pet_insurance has_veterinarian]],
      veterinarian_attributes: [:id, :first_name, :last_name, :email, :phone_number,
        address_attributes: %i[id street_line_1 street_line_2 city state country zip_code]])
  end
end
