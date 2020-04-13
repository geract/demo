# frozen_string_literal: true

class Users::V1::Adopters::PersonalInfosController < Users::V1::Adopters::BaseController
  def show
    render json: Users::Adopters::Profile::PersonalInfoPresenter.new(current_user).response, status: :ok
  end

  def update
    service = Adopter::Profile::SavePersonalInfo.new(current_user, adopter_profile_params)

    if service.perform
      render json: {profile: {}}, status: :ok
    else
      errors = service.profile.errors.full_messages
      render json: errors, status: :unprocessable_entity
    end
  end

  private

  def adopter_profile_params
    params.require(:profile).permit( :id, :has_co_adopter, :pronoun, :family_status, :birthday,
                                      address_attributes: %i[id street_line_1 street_line_2 city state zip_code country id],
                                      employment_attributes: [:id, :status, :years, :company, :pet_costs,
                                        address_attributes: %i[id street_line_1 street_line_2 city state zip_code country id]],
                                      pet_info_attributes: [:id,
                                        personal: %i[about_you ideal_pet adopt_reason is_military military_pet_plan]]
                                    )
  end
end
