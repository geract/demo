# frozen_string_literal: true

module Users
  module V1
    module Adopters
      class Applications::HomesController < PetApplicationController
        before_action :redirect_to_first_application_step, unless: :adopter_application?
        before_action :redirect_to_next_application_step, unless: :home?

        def show
          render json: Users::Adopters::PetApplications::HomePresenter.new(current_user).response, status: :ok
        end

        def update
          service = Adopter::Application::SaveHome.new(current_user, application_params)
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
            applicationable_attributes: [:id, 
              pet_info_attributes: [
                home: %i[kind has_pool is_pool_fenced has_yard yard is_rent is_landlord_allow_pets
                                    landlord_first_name landlord_last_name landlord_phone_number landlord_email
                                    is_landlord_contactable]
              ]
            ]
          )
        end

        def home?
          current_user.application.applicationable.completed_state?('home')
        end
      end
    end
  end
end
