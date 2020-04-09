# frozen_string_literal: true

module Users
  module V1
    module Adopters
      class Applications::PersonalInfosController < PetApplicationController
        def show
          render json: Users::Adopters::PetApplications::PersonalInfoPresenter.new(current_user).response, status: :ok
        end

        def update
          service = Adopter::Application::SavePersonalInfo.new(current_user, application_params)

          if service.perform
            render json: {application: {}}, status: :ok
          else
            errors = service.application.errors.full_messages
            render json: errors, status: :unprocessable_entity
          end
        end

        private
        def application_params
          params.require(:application).permit(:pet_id, :has_co_adopter,
                                              profile_attributes: [:id, :pronoun, :family_status, :birthday,
                                                address_attributes: %i[street_line_1 street_line_2 city state zip_code country id],
                                                employment_attributes: [:id, :status, :years, :company, :pet_costs,
                                                  address_attributes: %i[street_line_1 street_line_2 city state zip_code country id]],
                                              ],
                                              applicationable_attributes: [:id,
                                                pet_info_attributes: [
                                                  personal: %i[about_you ideal_pet adopt_reason is_military military_pet_plan]
                                                ]
                                              ])
        end
      end
    end
  end
end
