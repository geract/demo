class Users::Adopters::PetApplications::PersonalCoAdopterPresenter
  def initialize(adopter)
    @application = adopter.application
    @profile = adopter.profile
    @co_adopter = application.co_adopter
    @personal = application.applicationable.pet_info.personal
  end

  def response
    { application: { 
      is_address_same_as_adopter: profile.address == application.co_adopter&.address,
        applicationable_attributes: {
          pet_info_attributes: {
            personal: {
              co_adopter_relation: personal[:co_adopter_relation],
              pet_relation_change_owner: personal[:pet_relation_change_owner]
            },
          },
        },
        co_adopter_attributes: {
          email: co_adopter.email,
          profile_attributes: {
            first_name: co_adopter.profile.first_name,
            last_name: co_adopter.profile.last_name,
            phone_number: co_adopter.profile.phone_number,
            birthday: co_adopter.profile.birthday,
            address_attributes: {
              street_line_1: co_adopter.address.street_line_1,
              street_line_2: co_adopter.address.street_line_2,
              city: co_adopter.address.city,
              state: co_adopter.address.state,
              zip_code: co_adopter.address.zip_code,
              country: co_adopter.address.country,
            },
            employment_attributes: {
              status: co_adopter.employment.status,
              years: co_adopter.employment.years,
              company: co_adopter.employment.company,
              pet_costs: co_adopter.employment.pet_costs,
              address_attributes: {
                street_line_1: co_adopter.employment.address.street_line_1,
                street_line_2: co_adopter.employment.address.street_line_2,
                city: co_adopter.employment.address.city,
                state: co_adopter.employment.address.state,
                zip_code: co_adopter.employment.address.zip_code,
                country: co_adopter.employment.address.country,
              },
            }
          }
        },
      },
    }
  end

  private

  attr_reader :application, :profile, :personal, :co_adopter
end
