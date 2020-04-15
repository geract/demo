# frozen_string_literal: true

class Users::V1::Adopters::PersonalInfosController < Users::V1::Adopters::BaseController
  before_action :redirect_to_first_profile_step, unless: :adopter_profile?, only: :show

  def show
    render json: Users::Adopters::Profile::PersonalInfoPresenter.new(current_user), status: :ok
  end

  def update
    adopter = Adopter::Profile::SavePersonalInfo.new(current_user, adopter_profile_params)

    if adopter.perform
      render json: {profile: {}}, status: :ok
    else
      errors = adopter.profile.errors.full_messages
      render json: errors, status: :unprocessable_entity
    end
  end

  private

  def adopter_profile_params
    params.require(:profile).permit( :id, :has_co_adopter, :pronoun, :family_status, :birthday, :phone_number,
                                      address_attributes: %i[id street_line_1 street_line_2 city state zip_code country id],
                                      employment_attributes: [:id, :status, :years, :company, :pet_costs,
                                        address_attributes: %i[id street_line_1 street_line_2 city state zip_code country id]],
                                      pet_info_attributes: [:id,
                                        personal: %i[about_you ideal_pet adopt_reason is_military military_pet_plan receive_updates pet_costs]]
                                    )
  end
end
