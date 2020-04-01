FactoryBot.define do
  factory :inquery do
    pet_id { Faker::Number.number(digits: 5) }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone_number { Faker::Internet.email }
    email { Faker::Internet.email }
    city { Faker::Address.city }
    state { Faker::Address.state }
    reasons { Faker::Lorem.sentence(word_count: 10) }
  end

  factory :inquery_params, class: Hash do
    body do
      { inquery: {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          phone_number: Faker::Internet.email,
          email: Faker::Internet.email,
          city: Faker::Address.city,
          state: Faker::Address.state,
          reasons: Faker::Lorem.sentence(word_count: 10),
          pet_id: Faker::Number.number(digits: 5)
        }
      }
    end

    initialize_with { ActiveSupport::HashWithIndifferentAccess.new(attributes[:body]) }
  end

  factory :inquery_invalid_params, class: Hash do
    body do
      { inquery: {
          first_name: Faker::Name.first_name
        }
      }
    end

    initialize_with { ActiveSupport::HashWithIndifferentAccess.new(attributes[:body]) }
  end
end
 