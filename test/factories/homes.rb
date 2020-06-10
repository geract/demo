FactoryBot.define do
  factory :adopter_profile_home_params, class: Hash do
    body do
      { 
        profile: {
          pet_info_attributes: {
            home: {
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
              landlord_email: 'Test',
            }
          }
        }
      }
    end

    initialize_with { ActiveSupport::HashWithIndifferentAccess.new(attributes[:body]) }
  end
end
