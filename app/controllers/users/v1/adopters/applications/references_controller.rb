# frozen_string_literal: true

module Users
  module V1
    module Adopters
      class Applications::ReferencesController < PetApplicationController
        before_action :redirect_to_first_application_step, unless: :adopter_application?
        before_action :redirect_to_next_application_step, unless: :references?

        def update
          service = Adopter::Application::SaveReferences.new(current_user, application_params)
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
            references_attributes: %i[first_name last_name email phone_number relationship]
          )
        end

        def references?
          current_user.application.completed_state?('add_references')
        end
      end
    end
  end
end
