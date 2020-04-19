class Users::Adopters::Profile::HomePresenter
  def initialize(adopter)
    @profile = adopter.profile
    @pet_info = profile.pet_info
  end

  def as_json(*)
    { profile: {
        id: profile.id,
        pet_info_attributes: {
          home: {
            kind: pet_info.kind,
            has_pool: pet_info.has_pool,
            is_pool_fenced: pet_info.is_pool_fenced,
            has_yard: pet_info.has_yard,
            yard: pet_info.yard,
            is_rent: pet_info.is_rent,
            is_landlord_allow_pets: pet_info.is_landlord_allow_pets,
            is_landlord_contactable: pet_info.is_landlord_contactable,
            landlord_first_name: pet_info.landlord_first_name,
            landlord_last_name: pet_info.landlord_last_name,
            landlord_phone_number: pet_info.landlord_phone_number,
            landlord_email: pet_info.landlord_email,
          }
        }
      }
    }
  end

  private

  attr_reader :profile, :pet_info
end
