# frozen_string_literal: true

class Users::V1::Adopters::LifestylesController < Users::V1::Adopters::BaseController
  before_action :redirect_to_profile_step, unless: -> { current_user.profile.completed_status?('lifestyle') }

  def show
    render json: Users::Adopters::Profile::LifestylePresenter.new(current_user), status: :ok
  end

  def update
    profile = current_user.profile

    if Adopter::Profile::SaveLifestyle.perform(profile, adopter_profile_params)
      head :ok
    else
      render json: profile.errors.full_mesages, status: :unprocessable_entity
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
