class Users::V1::Objects::Adopters::PetInfoPresenter
  class << self
    def to_json(pet_info)
      return {} unless pet_info
      @pet_info = pet_info

      {
        id: pet_info.id,
        personal: personal_info,
        home: home_info,
        lifestyle: lifestyle_info,
        animal_history: animal_history_info,
        veterinarian_extra: veterinarian_extra_info
      }
    end

    private

    attr_reader :pet_info

    def personal_info
      {
        has_children: pet_info.has_children,
        children_ages: pet_info.children_ages,
        is_pet_allergic: pet_info.is_pet_allergic,
        pet_allergic_plan: pet_info.pet_allergic_plan,
        about_you: pet_info.about_you,
        ideal_pet: pet_info.ideal_pet,
        adopt_reason: pet_info.adopt_reason,
        is_military: pet_info.is_military,
        military_pet_plan: pet_info.military_pet_plan,
        receive_updates: pet_info.receive_updates,
        pet_costs: pet_info.pet_costs,
      }
    end

    def home_info
      {
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
        landlord_email: pet_info.landlord_email
      }
    end

    def lifestyle_info
      {
        living_place: pet_info.living_place,
        bad_weather_plan: pet_info.bad_weather_plan,
        hours_left: pet_info.hours_left,
        alone_place: pet_info.alone_place,
        walk_explanation: pet_info.walk_explanation,
        trainer: pet_info.trainer,
        energy: pet_info.energy,
        train_plan: pet_info.train_plan,
        experiences: pet_info.experiences,
      }
    end

    def animal_history_info
      {
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
      }
    end

    def veterinarian_extra_info
      {
        has_veterinarian: pet_info.has_veterinarian,
        is_contactable: pet_info.is_contactable,
        emergency_vet_bills_plan: pet_info.emergency_vet_bills_plan,
        is_pet_insurance: pet_info.is_pet_insurance,
      }
    end
  end
end