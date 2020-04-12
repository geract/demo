FactoryBot.define do
  factory :adopter_profile do
    pet_info
    first_name { "Ale" }
    last_name { "Jandra" }
    pronoun { "She" }
    family_status { "Single" }
    birthday { "2020-03-14" }
    phone_number { "1234567890" }

    after :build do |profile|
      profile.address = build(:adopter_address)
      profile.employment = build(:employment)
    end

    trait :personal_info do
      state { 'personal_info' }

      after :build do |adopter_profile|
        adopter_profile.pet_info.personal = { about_you: 'About you', ideal_pet: 'Ideal pet', adopt_reason: 'Adopt reason' }
      end
    end
    
    trait :personal_co_adopter do
      state { 'personal_co_adopter' }

      after :build do |adopter_profile|
        adopter_profile.pet_info.personal = adopter_profile.pet_info.personal.merge(pet_relation_change_owner: "Not sure yet... we'll see",
                                                                                co_adopter_relation: 'Sibling')
      end
    end

    trait :personal_final do
      state { 'personal_final' }

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
            owned_pet_age: '9+ years old'
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
      state { 'home' }

      after :build do |adopter_profile|
        adopter_profile.pet_info_attributes = { 
          home: {
            kind: 'Townhouse' 
          }
        }
      end
    end

    trait :lifestyle do
      state { 'lifestyle' }

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

    trait :completed do
      state { 'completed' }
    end
  end

  factory :co_adopter_profile, class: 'AdopterProfile' do
    first_name { "Gibran" }
    last_name { "GeDiez" }
    pronoun { "He" }
    family_status { "Single" }
    birthday { "2020-01-01" }
    phone_number { "1234567890" }

    after :build do |profile|
      profile.address = build(:adopter_address)
      profile.employment = build(:employment)
    end
  end
end
