# frozen_string_literal: true

class Users::V1::Adopters::HomesController < Users::V1::Adopters::BaseController
  before_action :redirect_to_profile_step, unless: -> { current_user.profile.completed_status?('home') }

  def show
    render json: Users::Adopters::Profile::HomePresenter.new(current_user), status: :ok
  end

  def update
    profile = current_user.profile

    if Adopter::Profile::SaveHomeService.perform(profile, adopter_profile_params)
      head :ok
    else
      render json: profile.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def adopter_profile_params
    params.require(:profile).permit(:id,
      pet_info_attributes: [:id,
        home: %i[kind has_pool is_pool_fenced has_yard yard is_rent is_landlord_allow_pets
                            landlord_first_name landlord_last_name landlord_phone_number landlord_email
                            is_landlord_contactable]])
  end
end
