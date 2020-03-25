# frozen_string_literal: true

module Users
  module V1
    module Adopters
      class Applications::LifestylesController < PetApplicationController
        before_action :redirect_to_first_application_step, unless: :adopter_application?
        before_action :redirect_to_next_application_step, unless: :lifestyle?

        def show
          render json: Users::Adopters::PetApplications::LifestylePresenter.new(current_user).response, status: :ok
        end

        def update
          service = User::Adopter::Application::SaveLifestyle.new(current_user, application_params)
          if  service.perform
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
                lifestyle: %i[living_place bad_weather_plan hours_left alone_place walk_explanation
                              trainer energy train_plan experiences]
              ]
            ]
          )
        end

        def lifestyle?
          current_user.application.applicationable.completed_state?('lifestyle')
        end
      end
    end
  end
end
