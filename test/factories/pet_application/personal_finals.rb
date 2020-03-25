FactoryBot.define do
  factory :personal_final_params, class: Hash do
    body do
      { application: {
          applicationable_attributes: {
            pet_info_attributes: {
              personal: {
                has_children: true,
                children_ages: 'Text',
                is_pet_allergic: true,
                pet_allergic_plan: 'Text',
              },
              animal_history: {
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
                owned_pet_age: 'String',
              },
              veterinarian_extra: {
                has_veterinarian: true,
                is_contactable: true,
                emergency_vet_bills_plan: 'String',
                is_pet_insurance: true,
              },
            },
          },
          veterinarian_attributes: {
            first_name: 'Doctor',
            last_name: 'Dolittle',
            email: 'dr_dolittle@gmail.com',
            phone_number: '2223334445',
            address_attributes: {
              street_line_1: 'Street Line #1',
              street_line_2: nil,
              city: 'San Francisco',
              state: 'CA',
              country: 'United States',
              zip_code: '11111',
            },
          },
        }
      }
    end

    initialize_with { ActiveSupport::HashWithIndifferentAccess.new(attributes[:body]) }
  end
end
