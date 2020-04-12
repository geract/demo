# frozen_string_literal: true

module Users
  module V1
    module Adopters
      class Applications::PersonalCoAdoptersController < PetApplicationController
        before_action :redirect_to_first_application_step, unless: :adopter_application?
        before_action :redirect_to_next_application_step, unless: :personal_co_adopter?

        def show
          render json: Users::Adopters::PetApplications::PersonalCoAdopterPresenter.new(current_user).response, status: :ok
        end

        def update
          service = Adopter::Application::SavePersonalCoAdopter.new(current_user, application_params)

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
            :is_address_same_as_adopter,
            co_adopter_attributes: [:id, :email,
              profile_attributes: [:id, :phone_number, :birthday, :first_name, :last_name, :phone_number,
                address_attributes: %i[id street_line_1 street_line_2 city state country zip_code],
                employment_attributes: [:id, :status, :years, :company,
                  address_attributes: %i[id street_line_1 street_line_2 city state country zip_code]
                ]
              ]
            ],
            applicationable_attributes: [:id, 
              pet_info_attributes: [
                personal: %i[co_adopter_relation pet_relation_change_owner]
              ]
            ],
          )
        end

        def personal_co_adopter?
          current_user.application.applicationable.completed_state?('personal_co_adopter')
        end
      end
    end
  end
end
