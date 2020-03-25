# frozen_string_literal: true

module Users
  module V1
    module Adopters
      class PetApplicationController < BaseController
        private

        def adopter_application?
          !!current_user.application
        end

        def next_application_step
          return [:adopters_applications, current_user.application.state] if current_user.application.completed?
          [:adopters_applications, current_user.application.applicationable.state]
        end

        def redirect_to_first_application_step
          redirect_to %i[adopters_applications personal_info]
        end

        def redirect_to_next_application_step
          redirect_to next_application_step
        end
      end
    end
  end
end
