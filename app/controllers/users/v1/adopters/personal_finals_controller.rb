# frozen_string_literal: true

module Users
  module V1
    module Adopters
      class Applications::PersonalFinalsController < PetApplicationController
        before_action :redirect_to_first_application_step, unless: :adopter_profile?
        before_action :redirect_to_next_application_step, unless: :personal_final?

        def show
          render json: Users::Adopters::PetApplications::PersonalFinalPresenter.new(current_user).response, status: :ok
        end

        def update
          service = Adopter::Application::SavePersonalFinal.new(current_user, application_params)
          if service.perform
            render json: {application: {}}, status: :ok
          else
            errors = service.application.errors.full_messages
            render json: errors, status: :unprocessable_entity
          end
        end

        private

        def application_params
          params.require(:application).permit(
            applicationable_attributes: [ :id,
              pet_info_attributes: [
                personal: %i[has_children children_ages is_pet_allergic pet_allergic_plan],
                animal_history: %i[has_pets pet_name pet_species pet_breed pet_sex pet_age
                                            has_owned_pets owned_pet_name owned_pet_species owned_pet_breed
                                            owned_pet_sex owned_pet_age],
                veterinarian_extra: %i[is_contactable emergency_vet_bills_plan is_pet_insurance has_veterinarian]
              ]
            ],
            veterinarian_attributes: [:id, :first_name, :last_name, :email, :phone_number,
                                      address_attributes: %i[id street_line_1 street_line_2 city state country zip_code]]
          )
        end

        def personal_final?
          current_user.application.applicationable.completed_state?('personal_final')
        end
      end
    end
  end
end
