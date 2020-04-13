# frozen_string_literal: true

class Users::V1::Adopters::LifestylesController < Users::V1::Adopters::BaseController
  before_action :redirect_to_first_application_step, unless: :adopter_profile?
  before_action :redirect_to_next_application_step, unless: :lifestyle?

  def show
    render json: Users::Adopters::Profile::LifestylePresenter.new(current_user).response, status: :ok
  end

  def update
    service = Adopter::Profile::SaveLifestyle.new(current_user, application_params)
    if  service.perform
      render json: {application: {}}, status: :ok
    else
      errors = service.profile.errors.full_messages
      render json: errors, status: :unprocessable_entity
    end
  end

  private

  def application_params
    params.require(:profile).permit(:id,
        pet_info_attributes: [
          lifestyle: %i[living_place bad_weather_plan hours_left alone_place walk_explanation
                        trainer energy train_plan experiences]])
  end

  def lifestyle?
    current_user.profile.completed_state?('lifestyle')
  end
end
