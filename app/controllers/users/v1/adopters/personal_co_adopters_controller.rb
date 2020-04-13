# frozen_string_literal: true

class Users::V1::Adopters::PersonalCoAdoptersController < Users::V1::Adopters::BaseController
  before_action :redirect_to_first_profile_step, unless: :adopter_profile?

  def show
    render json: Users::Adopters::Profile::PersonalCoAdopterPresenter.new(current_user), status: :ok
  end

  def update
    adopter = Adopter::Profile::SavePersonalCoAdopter.new(current_user, adopter_profile_params)

    if adopter.perform
      render json: {profile: {}}, status: :ok
    else
      errors = adopter.profile.errors.full_messages
      render json: errors, status: :unprocessable_entity
    end
  end

  private

  def adopter_profile_params
    params.require(:profile).permit(
      :id, :is_address_same_as_adopter,
      co_adopter_attributes: [:id, :email,
        profile_attributes: [:id, :phone_number, :birthday, :first_name, :last_name, :phone_number,
          address_attributes: %i[id street_line_1 street_line_2 city state country zip_code],
          employment_attributes: [:id, :status, :years, :company,
            address_attributes: %i[id street_line_1 street_line_2 city state country zip_code]
          ]
        ]
      ],
      pet_info_attributes: [:id,
        personal: %i[co_adopter_relation pet_relation_change_owner]
      ]
    )
  end
end
