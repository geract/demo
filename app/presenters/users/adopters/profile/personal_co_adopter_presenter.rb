class Users::Adopters::Profile::PersonalCoAdopterPresenter
  def initialize(adopter)
    @profile = adopter.profile
    @co_adopter = profile.co_adopter
    @pet_info = profile.pet_info
  end

  def as_json(*)
    { profile: { 
        id: profile.id,
        is_address_same_as_adopter: profile.address == profile.co_adopter&.address,
        pet_info_attributes: {
          id: pet_info.id,
          personal: {
            co_adopter_relation: pet_info[:personal][:co_adopter_relation],
            pet_relation_change_owner: pet_info[:personal][:pet_relation_change_owner]
          },
        },
        co_adopter_attributes: {
          id: co_adopter&.id,
          email: co_adopter.email,
          profile_attributes: {
            id: co_adopter.profile.id,
            first_name: co_adopter.profile.first_name,
            last_name: co_adopter.profile.last_name,
            phone_number: co_adopter.profile.phone_number,
            birthday: co_adopter.profile.birthday,
            address_attributes: {
              id: co_adopter.address.id,
              street_line_1: co_adopter.address.street_line_1,
              street_line_2: co_adopter.address.street_line_2,
              city: co_adopter.address.city,
              state: co_adopter.address.state,
              zip_code: co_adopter.address.zip_code,
              country: co_adopter.address.country,
            },
            employment_attributes: {
              id: co_adopter.employment.id,
              status: co_adopter.employment.status,
              years: co_adopter.employment.years,
              company: co_adopter.employment.company,
              pet_costs: co_adopter.employment.pet_costs,
              address_attributes: {
                id: co_adopter.employment.address.id,
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

  attr_reader :profile, :co_adopter, :pet_info
end
