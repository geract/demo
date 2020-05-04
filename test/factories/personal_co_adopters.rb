FactoryBot.define do
  factory :personal_co_adopter_params, class: Hash do
    body do
      { profile: { 
          is_address_same_as_adopter: false,
          pet_info_attributes: {
            personal: {
              co_adopter_relation: 'Friend',
              pet_relation_change_owner: 'Yes',
            },
          },
          co_adopter_attributes: {
            email: 'test@coadopter.com',
            first_name: 'Gibran',
            last_name: 'GeDiez',
            phone_number: '1234567890',
            birthday: '2020-01-01',
            address_attributes: {
              street_line_1:  'Street Line #1',
              street_line_2:  nil,
              city:  'San Francisco',
              state:  'CA',
              zip_code:  '11111',
              country:  'United States'
            },
            employment_attributes: {
              status: "Self-Employed",
              years: "1-2 years",
              company: "Unemployed",
              pet_costs: "123",
              address_attributes: {
                street_line_1:  'Street Line #1',
                street_line_2:  nil,
                city:  'San Francisco',
                state:  'CA',
                zip_code:  '11111',
                country:  'United States'
              }
            }
          }
        }
      }
    end

    initialize_with { ActiveSupport::HashWithIndifferentAccess.new(attributes[:body]) }
  end
end
