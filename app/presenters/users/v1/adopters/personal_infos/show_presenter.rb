class Users::V1::Adopters::PersonalInfos::ShowPresenter < BasePresenter
  def as_json(*)
    return {} if profile.nil? || pet_info.nil?

    { 
      profile: { 
        id: profile.id,
        has_co_adopter: !!profile.co_adopter,
        pronoun: profile.pronoun,
        family_status: profile.family_status,
        birthday: profile.birthday,
        phone_number: profile.phone_number,
        address_attributes: Users::V1::Objects::AddressPresenter.to_json(profile.address),
        employment_attributes: Users::V1::Objects::EmploymentPresenter.to_json(profile.employment),
        pet_info_attributes: {
          id: profile.pet_info.id,
          personal: {
            about_you: pet_info.about_you,
            ideal_pet: pet_info.ideal_pet,
            adopt_reason: pet_info.adopt_reason,
            is_military: pet_info.is_military,
            military_pet_plan: pet_info.military_pet_plan,
            receive_updates: pet_info.receive_updates,
            pet_costs: pet_info.pet_costs,
          }
        }
      }
    }
  end

  private

  def pet_info
    @pet_info ||= profile.pet_info
  end
end