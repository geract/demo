FactoryBot.define do
  factory :newsletter do
    email { Faker::Internet.email }
  end

  factory :newsletter_params, class: Hash do
    body do
      { newsletter: {
          email: Faker::Internet.email,
        }
      }
    end

    initialize_with { ActiveSupport::HashWithIndifferentAccess.new(attributes[:body]) }
  end
end
