class Users::Adopters::PetApplications::PersonalInfoPresenter
  def initialize(adopter)
    @application = adopter.application
    @profile = adopter.profile
    @personal = application.applicationable.pet_info.personal
  end

  def response
    { application: { 
        has_co_adopter: application.co_adopter_id.present?,
        profile_attributes: {
          pronoun: profile.pronoun,
          family_status: profile.family_status,
          birthday: profile.birthday,
          address_attributes: {
            street_line_1:  profile.address.street_line_1,
            street_line_2:  profile.address.street_line_2,
            city:  profile.address.city,
            state:  profile.address.state,
            zip_code:  profile.address.zip_code,
            country:  profile.address.country
          },
          employment_attributes: {
            status: profile.employment.status,
            years: profile.employment.years,
            company: profile.employment.company,
            address_attributes: {
              street_line_1: profile.employment.address.street_line_1,
              street_line_2: profile.employment.address.street_line_2,
              city:  profile.employment.address.city,
              state:  profile.employment.address.state,
              zip_code: profile.employment.address.zip_code,
              country: profile.employment.address.country
            },
          },
        },
        applicationable_attributes: {
          pet_info_attributes: {
            personal: {
              about_you: personal[:about_you],
              ideal_pet: personal[:ideal_pet],
              adopt_reason: personal[:adopt_reason],
              is_military: personal[:is_military],
              military_pet_plan: personal[:military_pet_plan],
            }
          }
        },
      },
    }
  end

  private

  attr_reader :application, :profile, :personal
end
