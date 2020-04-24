FactoryBot.define do
  factory :adopter_profile do
    pet_info
    first_name { "Ale" }
    last_name { "Jandra" }
    pronoun { "She" }
    family_status { "Single" }
    birthday { "2020-03-14" }
    phone_number { "1234567890" }

    trait :personal_info do
      status { 'personal_info' }

      after :build do |adopter_profile|
        adopter_profile.address = build(:adopter_address)
        adopter_profile.employment = build(:employment)
        adopter_profile.pet_info.personal = { about_you: 'About you', ideal_pet: 'Ideal pet', adopt_reason: 'Adopt reason' }
      end
    end

    trait :personal_co_adopter do
      co_adopter
      status { 'personal_co_adopter' }

      after :build do |adopter_profile|
        adopter_profile.pet_info.personal = adopter_profile.pet_info.personal.merge(pet_relation_change_owner: "Not sure yet... we'll see",
                                                                                co_adopter_relation: 'Sibling')
      end
    end

    trait :personal_final do
      status { 'personal_final' }

      after :build do |adopter_profile|
        adopter_profile.pet_info_attributes = {
          animal_history: {
            has_pets: true,
            pet_name: 'Shadow',
            pet_species: 'Dog',
            pet_breed: 'Golden Retriever',
            pet_sex: 'Male/Unaltered',
            pet_age: '9+ years old',
            has_owned_pets: true,
            owned_pet_name: 'Lassie',
            owned_pet_species: 'Dog',
            owned_pet_breed: 'Collie',
            owned_pet_sex: 'Female/Unaltered',
            owned_pet_age: '9+ years old',
            owned_pet_where: 'ded'
          },
          veterinarian_extra: {
            is_contactable: true,
            is_pet_insurance: true,
            emergency_vet_bills_plan: 'Pay all dues'
          }
        }
      end
    end

    trait :home do
      veterinarian
      status { 'home' }

      after :build do |adopter_profile|
        adopter_profile.pet_info_attributes = { 
          home: {
            kind: 'Townhouse' 
          }
        }
      end
    end

    trait :lifestyle do
      status { 'lifestyle' }

      after :build do |adopter_profile|
        adopter_profile.pet_info_attributes = {
          lifestyle: {
            living_place: 'Outside',
            bad_weather_plan: 'Garage',
            hours_left: '8 hours',
            alone_place: 'free in the house',
            walk_explanation: '2 hours by me',
            train_plan: 'Not sure now',
            experiences: 'No experiences',
            trainer: 'No trainer for now',
            energy: 'high energy'
          }
        }
      end
    end

    trait :agreements do
      status { 'agreements' }

      home_visit_agreement   { true }
      adoption_fee_agreement { true }
    end

    trait :references do
      status { 'add_references' }

      after :build do |profile|
        3.times do
          profile.references << build(:reference, adopter_profile: profile)
        end
      end
    end

    trait :completed do
      status { 'completed' }
    end

    trait :with_adopter do
      adopter { build(:adopter) }
    end

    factory :adopter_profile_with_personal_co_adopter, traits: [:personal_info, :personal_co_adopter]
    factory :adopter_profile_with_personal_final, traits: [:personal_info, :personal_co_adopter, :personal_final]
    factory :adopter_profile_with_home, traits: [:personal_info, :personal_co_adopter, :personal_final, :home]
    factory :adopter_profile_with_lifestyle, traits: [:personal_info, :personal_co_adopter, :personal_final, :home, :lifestyle]
    factory :adopter_profile_with_agreements, traits: [:personal_info, :personal_co_adopter, :personal_final, :home, :lifestyle, :agreements]
    factory :adopter_profile_with_references, traits: [:personal_info, :personal_co_adopter, :personal_final, :home, :lifestyle, :agreements, :references]
    factory :adopter_profile_completed, traits: [:personal_info, :personal_co_adopter, :personal_final, :home, :lifestyle, :agreements, :references, :completed]
    factory :adopter_profile_completed_with_adopter, traits: [:personal_info, :personal_co_adopter, :personal_final, :home, :lifestyle, :agreements, :references, :completed, :with_adopter]
  end
end
