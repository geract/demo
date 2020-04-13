FactoryBot.define do
  factory :personal_info_params, class: Hash do
    body do
      { profile: { 
          has_co_adopter: true,
          pronoun: 'She',
          family_status: 'Single',
          birthday: '2020-03-14',
          address_attributes: {
            street_line_1: 'Street Line #1',
            street_line_2: nil,
            city: 'San Francisco',
            state: 'CA',
            zip_code: '11111',
            country: 'United States'
          },
          employment_attributes: {
            status: "Self-Employed",
            years: "1-2 years",
            company: "Unemployed",
            address_attributes: {
              street_line_1:  'Street Line #1',
              street_line_2:  nil,
              city:  'San Francisco',
              state:  'CA',
              zip_code:  '11111',
              country:  'United States'
            },
          },
          pet_info_attributes: {
            personal: {
              about_you: 'test',
              ideal_pet: 'test',
              adopt_reason: 'test',
              is_military: 'true',
              military_pet_plan: 'test'
            },
          },
        },
      }
    end

    initialize_with { ActiveSupport::HashWithIndifferentAccess.new(attributes[:body]) }
  end
end
