# frozen_string_literal: true

class Users::V1::Adopters::LifestylesController < Users::V1::Adopters::BaseController
  before_action :redirect_to_profile_step, unless: :adopter_profile?
  before_action :redirect_to_next_profile_step, unless: :lifestyle?

  def show
    render json: Users::Adopters::Profile::LifestylePresenter.new(current_user), status: :ok
  end

  def update
    adopter = Adopter::Profile::SaveLifestyle.new(current_user, adopter_profile_params)
    if  adopter.perform
      render json: {application: {}}, status: :ok
    else
      errors = adopter.profile.errors.full_messages
      render json: errors, status: :unprocessable_entity
    end
  end

  private

  def adopter_profile_params
    params.require(:profile).permit(:id,
        pet_info_attributes: [
          lifestyle: %i[living_place bad_weather_plan hours_left alone_place walk_explanation
                        trainer energy train_plan experiences]])
  end

  def lifestyle?
    current_user.profile.completed_status?('lifestyle')
  end
end
