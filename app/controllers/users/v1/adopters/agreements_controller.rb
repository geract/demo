# frozen_string_literal: true

module Users
  module V1
    module Adopters
      class Applications::AgreementsController < PetApplicationController
        before_action :redirect_to_first_application_step, unless: :adopter_profile?
        before_action :redirect_to_next_application_step, unless: :agreements?

        def show
          render json: Users::Adopters::PetApplications::AgreementsPresenter.new(current_user).response, status: :ok
        end

        def update
          application = current_user.application

          if application.update(application_params)
            application.continue!
            render json: {application: {}}, status: :ok
          else
            errors = service.application.errors.full_messages
            render json: errors, status: :unprocessable_entity
          end
        end

        private

        def application_params
          params.require(:application).permit(:home_visit_agreement, :adoption_fee_agreement)
        end
        
        def agreements?
          current_user.application.completed_state?('agreements')
        end
      end
    end
  end
end
