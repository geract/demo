class Users::Adopters::Profile::PersonalInfoPresenter
  def initialize(adopter)
    @profile = adopter.profile
    @personal = profile.pet_info.personal
  end

  def response
    { profile: { 
        id: profile.id,
        has_co_adopter: profile.co_adopter_id.present?,
        pronoun: profile.pronoun,
        family_status: profile.family_status,
        birthday: profile.birthday,
        address_attributes: {
          id: profile.address.id,
          street_line_1:  profile.address.street_line_1,
          street_line_2:  profile.address.street_line_2,
          city:  profile.address.city,
          state:  profile.address.state,
          zip_code:  profile.address.zip_code,
          country:  profile.address.country
        },
        employment_attributes: {
          id: profile.employment.id,
          status: profile.employment.status,
          years: profile.employment.years,
          company: profile.employment.company,
          address_attributes: {
            id: profile.employment.address.id,
            street_line_1: profile.employment.address.street_line_1,
            street_line_2: profile.employment.address.street_line_2,
            city:  profile.employment.address.city,
            state:  profile.employment.address.state,
            zip_code: profile.employment.address.zip_code,
            country: profile.employment.address.country
          },
        },
        pet_info_attributes: {
          id: profile.pet_info.id,
          personal: {
            about_you: personal[:about_you],
            ideal_pet: personal[:ideal_pet],
            adopt_reason: personal[:adopt_reason],
            is_military: personal[:is_military],
            military_pet_plan: personal[:military_pet_plan],
          }
        }
      },
    }
  end

  private

  attr_reader :profile, :personal
end
