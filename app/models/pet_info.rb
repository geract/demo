class PetInfo < ApplicationRecord
  belongs_to :adopter_profile, optional: true
  
  PERSONAL_FIELDS = %i[about_you ideal_pet adopt_reason is_military military_pet_plan co_adopter_relation
              pet_relation_change_owner has_children children_ages is_pet_allergic pet_allergic_plan pet_costs receive_updates].freeze

  VETERINARIAN_EXTRA_FIELDS = %i[is_contactable emergency_vet_bills_plan is_pet_insurance has_veterinarian created_at].freeze

  HOME_FIELDS = %i[kind has_pool is_pool_fenced has_yard yard is_rent is_landlord_allow_pets is_landlord_contactable
                   landlord_first_name landlord_last_name landlord_email landlord_phone_number].freeze

  ANIMAL_HISTORY_FIELDS = %i[has_pets has_owned_pets pet_name pet_species pet_breed pet_sex pet_age
              owned_pet_name owned_pet_species owned_pet_breed owned_pet_sex owned_pet_age].freeze

  LIFESTYLE_FIELDS = %i[living_place bad_weather_plan hours_left alone_place walk_explanation train_plan experiences
              trainer energy].freeze

  store :personal, accessors: PERSONAL_FIELDS
  store :home, accessors: HOME_FIELDS
  store :veterinarian_extra, accessors: VETERINARIAN_EXTRA_FIELDS
  store :animal_history, accessors: ANIMAL_HISTORY_FIELDS
  store :lifestyle, accessors: LIFESTYLE_FIELDS
end
