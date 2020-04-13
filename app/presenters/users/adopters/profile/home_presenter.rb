class Users::Adopters::Profile::HomePresenter
  def initialize(adopter)
    @profile = adopter.profile
    @home = profile.pet_info.home
  end

  def response
    { profile: {
        id: profile.id,
        pet_info_attributes: {
          home: {
            kind: home[:kind],
            has_pool: home[:has_pool],
            is_pool_fenced: home[:is_pool_fenced],
            has_yard: home[:has_yard],
            yard: home[:yard],
            is_rent: home[:is_rent],
            is_landlord_allow_pets: home[:is_landlord_allow_pets],
            is_landlord_contactable: home[:is_landlord_contactable],
            landlord_first_name: home[:landlord_first_name],
            landlord_last_name: home[:landlord_last_name],
            landlord_phone_number: home[:landlord_phone_number],
            landlord_email: home[:landlord_email],
          }
        }
      }
    }
  end

  private

  attr_reader :home, :profile
end
