class Users::Adopters::Profile::PersonalInfoPresenter
  def initialize(adopter)
    @profile = adopter.profile
    @pet_info = profile.pet_info

    return {} if profile.nil? || pet_info.nil?
  end

  def as_json(*)
    { profile: { 
        id: profile.id,
        has_co_adopter: !!profile.co_adopter,
        pronoun: profile.pronoun,
        family_status: profile.family_status,
        birthday: profile.birthday,
        phone_number: profile.phone_number,
        address_attributes: {
          id: profile.address&.id,
          street_line_1:  profile.address&.street_line_1,
          street_line_2:  profile.address&.street_line_2,
          city:  profile.address&.city,
          state:  profile.address&.state,
          zip_code:  profile.address&.zip_code,
          country:  profile.address&.country
        },
        employment_attributes: {
          id: profile.employment&.id,
          status: profile.employment&.status,
          years: profile.employment&.years,
          company: profile.employment&.company,
          address_attributes: {
            id: profile.employment&.address&.id,
            street_line_1: profile.employment&.address&.street_line_1,
            street_line_2: profile.employment&.address&.street_line_2,
            city:  profile.employment&.address&.city,
            state:  profile.employment&.address&.state,
            zip_code: profile.employment&.address&.zip_code,
            country: profile.employment&.address&.country
          },
        },
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
      },
    }
  end

  private

  attr_reader :profile, :pet_info
end
