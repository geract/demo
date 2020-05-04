class Users::Adopters::Profile::PersonalFinalPresenter
  def initialize(adopter)
    @profile = adopter.profile
    @veterinarian = profile.veterinarian
    @pet_info = profile.pet_info
  end
  
  def as_json(*)
    { profile: {
        id: profile.id,
        pet_info_attributes: {
          id: profile.pet_info.id,
          personal: {
            has_children: pet_info.has_children,
            children_ages: pet_info.children_ages,
            is_pet_allergic: pet_info.is_pet_allergic,
            pet_allergic_plan: pet_info.pet_allergic_plan,
          },
          animal_history: {
            has_pets: pet_info.has_pets,
            pet_name: pet_info.pet_name,
            pet_species: pet_info.pet_species,
            pet_breed: pet_info.pet_breed,
            pet_sex: pet_info.pet_sex,
            pet_age: pet_info.pet_age,
            has_owned_pets: pet_info.has_owned_pets,
            owned_pet_name: pet_info.owned_pet_name,
            owned_pet_species: pet_info.owned_pet_species,
            owned_pet_breed: pet_info.owned_pet_breed,
            owned_pet_sex: pet_info.owned_pet_sex,
            owned_pet_age: pet_info.owned_pet_age,
            owned_pet_where: pet_info.owned_pet_where,
          },
          veterinarian_extra: {
            has_veterinarian: pet_info.has_veterinarian,
            is_contactable: pet_info.is_contactable,
            emergency_vet_bills_plan: pet_info.emergency_vet_bills_plan,
            is_pet_insurance: pet_info.is_pet_insurance,
          },
        },
        veterinarian_attributes: {
          id: veterinarian&.id,
          first_name: veterinarian&.first_name,
          last_name: veterinarian&.last_name,
          email: veterinarian&.email,
          phone_number: veterinarian&.phone_number,
          address_attributes: {
            id: veterinarian&.address&.id,
            street_line_1: veterinarian&.address&.street_line_1,
            street_line_2: veterinarian&.address&.street_line_2,
            city: veterinarian&.address&.city,
            state: veterinarian&.address&.state,
            country: veterinarian&.address&.country,
            zip_code: veterinarian&.address&.zip_code,
          }
        }
      }
    }
  end

  private

  attr_reader :profile, :veterinarian, :pet_info
end
