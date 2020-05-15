if Rails.env.staging?
  legal_address = LegalAddress.new(name: 'PetParent', address: '5th. Avenue', city: 'Manhattan', state: 'New York', zip_code: '99923', main_location: true)
  organization = Organization.create(name: 'PetParent', email: 'pph@pph.com', phone: '1231231231', director: 'Dana', legal_address: legal_address)

  adopters_data = [
    {
      adopter: { email: 'adopter@pph.com', password: 'Topsecr3t' },
    },
    {
      adopter: { email: 'adopter1@pph.com', password: 'Topsecr3t' },
      profile: {
        pronoun: 'He', first_name: 'Gerardo', last_name: 'Sanchez', birthday: '1960-04-20', family_status: 'Single', home_visit_agreement: true, adoption_fee_agreement: true, status: 'completed', phone_number: '0987667890',
        address_attributes: { street_line_1: '8040 Ashley Lane', city: 'Calhoun', state: 'GA', zip_code: '30701', country: 'United States' },
        employment_attributes: { status: 'Self-Employed', years: '<1 year', company: 'Micasa',
          address_attributes: { street_line_1: '8040 Ashley Lane', city: 'Calhoun', state: 'GA', zip_code: '30701', country: 'United States' },
        },
        preferences: {age: 1, sex: 'Male', size: 'Small', hair: 'Brown', energy: 'active', breed: 'Pug', special_needs: 'true'},
        co_adopter_attributes: {
          first_name: 'Ale', last_name: 'Smith', birthday: '1987-01-02', phone_number: '0987667890', email: 'ale@pph.com',
          address_attributes: { street_line_1: '8040 Ashley Lane', city: 'Calhoun', state: 'GA', zip_code: '30701', country: 'United States' },
          employment_attributes: { status: 'Self-Employed', years: '<1 year', company: 'Micasa',
            address_attributes: { street_line_1: '8040 Ashley Lane', city: 'Calhoun', state: 'GA', zip_code: '30701', country: 'United States' },
          },
        },
        references_attributes: [
          {
            first_name: 'Pedro',
            last_name: 'Paramo',
            email: 'pp@example.com',
            phone_number: '1234565432',
            relationship: 'Friend',
          },
        ],
        pet_info_attributes: {
          personal: {
            has_children: false,
            children_ages: nil,
            is_pet_allergic: false,
            pet_allergic_plan: nil,
            about_you: 'I am a dog person, and recently moved. I have a remote job, so I stay in my house most of the time. Alone :(',
            ideal_pet: 'Any pet is welcome. Breeds are irrelevant for me',
            adopt_reason: 'I feel lonely in this new city, and a pet would suit me nicely',
            is_military: false,
            military_pet_plan: nil,
            receive_updates: true,
            pet_costs: '1000',
          },
          home: {
            kind: 'Townhouse',
            has_pool: false,
            is_pool_fenced: nil,
            has_yard: false,
            yard: 'Unfenced',
            is_rent: false,
            is_landlord_allow_pets: nil,
            is_landlord_contactable: nil,
            landlord_first_name: nil,
            landlord_last_name: nil,
            landlord_phone_number: nil,
            landlord_email: nil
          },
          lifestyle: {
            living_place: 'Inside',
            bad_weather_plan: 'Keep him safe inside',
            hours_left: '2 - 5',
            alone_place: 'Ask a friend to take care of him',
            walk_explanation: 'Just go for a walk xd',
            energy: 'Active',
            train_plan: 'I will hire a proffesional trainer',
            trainer: 'I will hire a professional trainer',
            experiences: 'Thankfully I do not have a bad experience to tell',
          },
          animal_history: {
            has_pets: true,
            pet_name: 'Chumcha',
            pet_species: 'Cat',
            pet_breed: 'Idk',
            pet_sex: 'Male',
            pet_age: '3',
            has_owned_pets: true,
            owned_pet_name: 'Nala',
            owned_pet_species: 'Dog',
            owned_pet_breed: 'Husky',
            owned_pet_sex: 'Female',
            owned_pet_age: '7',
            owned_pet_where: 'died',
          },
          veterinarian_extra: {
            has_veterinarian: false,
            is_contactable: true,
            emergency_vet_bills_plan: nil,
            is_pet_insurance: false,
          }
        }
      },
    },
    {
      adopter: { email: 'adopter2@pph.com', password: 'Topsecr3t' },
      profile: { 
        pronoun: 'He', first_name: 'Gibran', last_name: 'Torres', birthday: '2001-01-01', family_status: 'Single', home_visit_agreement: true, adoption_fee_agreement: true, status: 'completed', phone_number: '0987667890',
        address_attributes: { street_line_1: '3854 E. County Drive', city: 'New York', state: 'NY', zip_code: '10220', country: 'United States' },
        employment_attributes: { status: 'Employed', years: '<1 year', company: 'Yahoogle',
          address_attributes: { street_line_1: '7371 Pendergast Rd.', city: 'New York', state: 'NY', zip_code: '11700', country: 'United States' },
        },
        preferences: {age: 0, sex: 'Male', size: 'Small', hair: 'Any', energy: 'active', breed: 'Pug', special_needs: 'true'},
        veterinarian_attributes: {
          first_name: 'Dr.',
          last_name: 'Dolittle',
          email: 'dr.doolitte@provets.com',
          phone_number: '3344556677',
          address_attributes: { street_line_1: '8040 Ashley Lane', city: 'Calhoun', state: 'GA', zip_code: '30701', country: 'United States' },
        },
        references_attributes: [
          {
            first_name: 'Pedro',
            last_name: 'Paramo',
            email: 'pp@example.com',
            phone_number: '1234565432',
            relationship: 'Friend',
          },
          {
            first_name: 'Dr.',
            last_name: 'Dolittle',
            email: 'dr.dolittle@provets.com',
            phone_number: '0011992233',
            relationship: 'Veterinarian',
          }
        ],
        pet_info_attributes: {
          personal: {
            has_children: true,
            children_ages: '5, 7 and 34',
            is_pet_allergic: true,
            pet_allergic_plan: 'Go to the hospital',
            about_you: 'I am a software developer who likes animals',
            ideal_pet: 'A small pet to play with my children',
            adopt_reason: 'I would like to teach my children what it is to have a responsability. They will feed the dog, play with him, and take care in general. I will be supervising them',
            is_military: true,
            military_pet_plan: 'My children will take care of him',
            receive_updates: true,
            pet_costs: '1000',
          },
          home: {
            kind: 'Townhouse',
            has_pool: true,
            is_pool_fenced: true,
            has_yard: true,
            yard: 'Unfenced',
            is_rent: true,
            is_landlord_allow_pets: true,
            is_landlord_contactable: true,
            landlord_first_name: 'Senior',
            landlord_last_name: 'Barriga',
            landlord_phone_number: '6630571333',
            landlord_email: 'senior.b@vecindad.com'
          },
          lifestyle: {
            living_place: 'Inside',
            bad_weather_plan: 'Keep him safe inside',
            hours_left: 'There is always someone in the house',
            alone_place: 'Ask a friend to take care of him',
            walk_explanation: 'My childran will take a walk with the pet in a park nearby our house',
            energy: 'Active',
            train_plan: 'I will hire a proffesional trainer',
            trainer: 'I will hire a professional trainer',
            experiences: 'Thankfully I do not have a bad experience to tell',
          },
          animal_history: {
            has_pets: true,
            pet_name: 'Matador',
            pet_species: 'Dog',
            pet_breed: 'Pitbull',
            pet_sex: 'Male',
            pet_age: '1',
            has_owned_pets: false,
            owned_pet_name: nil,
            owned_pet_species: nil,
            owned_pet_breed: nil,
            owned_pet_sex: nil,
            owned_pet_age: nil,
            owned_pet_where: nil
          },
          veterinarian_extra: {
            has_veterinarian: true,
            is_contactable: true,
            emergency_vet_bills_plan: nil,
            is_pet_insurance: false,
          }
        }
      }
    }
  ]

  adopters = adopters_data.map do |data|
    adopter = Adopter.new(data[:adopter])
    adopter.build_profile(data[:profile])
    adopter.confirm
    adopter.save
    adopter
  end

  rescuer_admin = RescuerAdmin.new(email: 'ra1@pph.com', password: 'Topsecr3t')
  rescuer_admin.build_profile(first_name: 'Juan', last_name: 'Rescuer', phone: '6630671333', title: 'dev', organization: organization)
  rescuer_admin.save

  cerberus = Pet.create(age: 1, breed: 'Chihuahua', description: 'Small but deadly', housed: 'Shelter', name: 'Cerberus', added_by: rescuer_admin,
    price: 555, sex: 'Male', size: 'Small', status: 'created', location: 'Atlantic City, NJ', organization: organization,
    personality: { good_with_dogs: true, good_with_cats: false, good_with_children: true })

  doggo = Pet.create(age: 1, breed: 'Shiba Inu', description: 'Happy dog', housed: 'Shelter', name: 'Doggo', added_by: rescuer_admin,
              price: 100, sex: 'Male', size: 'Large', status: 'created', location: 'Boonton, NJ', organization: organization,
              personality: { good_with_dogs: true, good_with_cats: false, good_with_children: true })


  cerberus_application = cerberus.applications.create(adopter_profile: adopters[1].profile, organization: organization)

  doggo.applications.create(adopter_profile: adopters[1].profile, organization: organization)
  doggo_application = doggo.applications.create(adopter_profile: adopters[2].profile, organization: organization)

  adopters[2].messages.create(pet_application: doggo_application, message: 'Hi, do you have more pictures of Doggo? :D')
  rescuer_admin.messages.create(pet_application: doggo_application, message: 'Sure, I just updated his profile. You should be able to see more images of Doggo now 🐶')
  adopters[2].messages.create(pet_application: doggo_application, message: 'Thank you very much!')

  adopters[1].messages.create(pet_application: cerberus_application, message: 'Hello! Is there any chance I can get to see the dog physically before continuing my application?')
end
