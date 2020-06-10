FactoryBot.define do
  factory :personal_info_params, class: Hash do
    body do
      { 
        profile: { 
          has_co_adopter: true,
          pronoun: 'She',
          family_status: 'Single',
          birthday: '2020-03-14',
          phone_number: '1231231231',
          address_attributes: {
            street_line_1: '8587 West School Dr. ',
            street_line_2: nil,
            city: 'New York',
            state: 'NY',
            zip_code: '10002',
            country: 'United States'
          },
          employment_attributes: {
            status: "Employed",
            years: "1-2 years",
            company: "Kuski",
            address_attributes: {
              street_line_1:  '960 Nicolls Lane',
              street_line_2:  nil,
              city:  'Mountain View',
              state:  'CA',
              zip_code:  '94102',
              country:  'United States'
            },
          },
          pet_info_attributes: {
            personal: {
              about_you: 'Good with dogs',
              ideal_pet: 'Fluffy',
              adopt_reason: 'I like pets',
              is_military: false,
              military_pet_plan: '',
              receive_updates: false,
              pet_costs: '1000'
            },
          },
        },
      }
    end

    initialize_with { ActiveSupport::HashWithIndifferentAccess.new(attributes[:body]) }
  end
end
