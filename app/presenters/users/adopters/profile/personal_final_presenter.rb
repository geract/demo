class Users::Adopters::Profile::PersonalFinalPresenter
  def initialize(adopter)
    @profile = adopter.profile
    @veterinarian = profile.veterinarian
    @pet_info = profile.pet_info
  end
  
  def response
    { profile: {
        id: profile.id,
        pet_info_attributes: {
          id: profile.pet_info.id,
          personal: {
            has_children: pet_info.personal[:has_children],
            children_ages: pet_info.personal[:children_ages],
            is_pet_allergic: pet_info.personal[:is_pet_allergic],
            pet_allergic_plan: pet_info.personal[:pet_allergic_plan],
          },
          animal_history: {
            has_pets: pet_info.animal_history[:has_pets],
            pet_name: pet_info.animal_history[:pet_name],
            pet_species: pet_info.animal_history[:pet_species],
            pet_breed: pet_info.animal_history[:pet_breed],
            pet_sex: pet_info.animal_history[:pet_sex],
            pet_age: pet_info.animal_history[:pet_age],
            has_owned_pets: pet_info.animal_history[:has_owned_pets],
            owned_pet_name: pet_info.animal_history[:owned_pet_name],
            owned_pet_species: pet_info.animal_history[:owned_pet_species],
            owned_pet_breed: pet_info.animal_history[:owned_pet_breed],
            owned_pet_sex: pet_info.animal_history[:owned_pet_sex],
            owned_pet_age: pet_info.animal_history[:owned_pet_age],
          },
          veterinarian_extra: {
            has_veterinarian: pet_info.veterinarian_extra[:has_veterinarian],
            is_contactable: pet_info.veterinarian_extra[:is_contactable],
            emergency_vet_bills_plan: pet_info.veterinarian_extra[:emergency_vet_bills_plan],
            is_pet_insurance: pet_info.veterinarian_extra[:is_pet_insurance],
          },
        },
        veterinarian_attributes: {
          id: veterinarian.id,
          first_name: veterinarian.first_name,
          last_name: veterinarian.last_name,
          email: veterinarian.email,
          phone_number: veterinarian.phone_number,
          address_attributes: {
            id: veterinarian.address.id,
            street_line_1: veterinarian.address.street_line_1,
            street_line_2: veterinarian.address.street_line_2,
            city: veterinarian.address.city,
            state: veterinarian.address.state,
            country: veterinarian.address.country,
            zip_code: veterinarian.address.zip_code,
          }
        }
      }
    }
  end

  private

  attr_reader :profile, :veterinarian, :pet_info
end
