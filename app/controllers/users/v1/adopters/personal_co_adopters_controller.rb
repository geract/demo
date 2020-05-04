# frozen_string_literal: true

class Users::V1::Adopters::PersonalCoAdoptersController < Users::V1::Adopters::BaseController
  before_action :redirect_to_profile_step, unless: -> { current_user.profile&.completed_status?('personal_co_adopter') }

  def show
    render json: Users::Adopters::Profile::PersonalCoAdopterPresenter.new(current_user), status: :ok
  end

  def update
    profile = current_user.profile
    profile.build_co_adopter unless profile.co_adopter

    if Adopter::Profile::SavePersonalCoAdopter.perform(profile, adopter_profile_params)
      head :ok
    else
      render json: {errors: profile.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private

  def adopter_profile_params
    params.require(:profile).permit(
      :id, :is_address_same_as_adopter,
      co_adopter_attributes: [:id, :email, :phone_number, :birthday, :first_name, :last_name,
        address_attributes: %i[id street_line_1 street_line_2 city state country zip_code],
        employment_attributes: [:id, :status, :years, :company,
          address_attributes: %i[id street_line_1 street_line_2 city state country zip_code]
        ]
      ],
      pet_info_attributes: [:id,
        personal: %i[co_adopter_relation pet_relation_change_owner]
      ]
    )
  end
end
