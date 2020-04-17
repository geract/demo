# frozen_string_literal: true

class Users::V1::Adopters::HomesController < Users::V1::Adopters::BaseController
  before_action :redirect_to_profile_step, unless: :adopter_profile?
  before_action :redirect_to_next_profile_step, unless: :home?

  def show
    render json: Users::Adopters::Profile::HomePresenter.new(current_user), status: :ok
  end

  def update
    adopter = Adopter::Profile::SaveHome.new(current_user, adopter_profile_params)
    if adopter.perform
      render json: {application: {}}, status: :ok
    else
      errors = adopter.profile.errors.full_messages
      render json: errors, status: :unprocessable_entity
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

  def home?
    current_user.profile.completed_status?('home')
  end
end
