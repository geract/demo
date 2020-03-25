FactoryBot.define do
  factory :pet_info do
    personal {{
      about_you: 'test', # Sent in PersonalInfosController
      ideal_pet: 'test',
      adopt_reason: 'test',
      is_military: 'true',
      military_pet_plan: 'test',

      co_adopter_relation: 'Friend',  # Sent in PersonalCoAdoptersController
      pet_relation_change_owner: 'Yes',

      has_children: true,
      children_ages: 'Text',
      is_pet_allergic: true,
      pet_allergic_plan: 'Text'
    }}
    animal_history {{
      has_pets: true,
      pet_name: 'String',
      pet_species: 'String',
      pet_breed: 'String',
      pet_sex: 'String',
      pet_age: 'String',
      has_owned_pets: true,
      owned_pet_name: 'String',
      owned_pet_species: 'String',
      owned_pet_breed: 'String',
      owned_pet_sex: 'String',
      owned_pet_age: 'String'
    }}
    home {{
      kind: 'Test',
      has_pool: true,
      is_pool_fenced: true,
      has_yard: true,
      yard: 'Test',
      is_rent: true,
      is_landlord_allow_pets: 'Test',
      is_landlord_contactable: true,
      landlord_first_name: 'Test',
      landlord_last_name: 'Test',
      landlord_phone_number: 'Test',
      landlord_email: 'Test'
    }}
    lifestyle {{
      living_place: 'String',
      bad_weather_plan: 'String',
      hours_left: 'String',
      alone_place: 'String',
      walk_explanation: 'String',
      trainer: 'String',
      energy: 'String',
      train_plan: 'String',
      experiences: 'String'
    }}
    veterinarian_extra {{
      has_veterinarian: true,
      is_contactable: true,
      emergency_vet_bills_plan: 'String',
      is_pet_insurance: true
    }}
  end
end
