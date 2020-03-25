class Users::Adopters::PetApplications::HomePresenter
  def initialize(adopter)
    @home = adopter.application.applicationable.pet_info.home
  end

  def response
    { application: {
        applicationable_attributes: {
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
            },
          },
        },
      },
    }
  end

  private

  attr_reader :home
end
