FactoryBot.define do
  factory :reference do
    first_name      { 'Juanito' }
    last_name       { 'Bananas' }
    phone_number    { '3157863467' }
    relationship    { 'Sibling' }
    email           { 'juanito@bananas.com' }

    trait :with_adopter do
      after :build do |reference|
        adopter = build(:adopter, :with_profile_references)
        reference.adopter_profile = adopter.profile
      end
    end
  end

  factory :adopter_profile_references_params, class: Hash do
    body do
      { profile: { 
          references_attributes: [
            {
              first_name: 'String',
              last_name: 'String',
              email: 'reference@example.com',
              phone_number: 'String',
              relationship: 'Friend',
            },{
              first_name: 'String',
              last_name: 'String',
              email: 'reference@example.com',
              phone_number: 'String',
              relationship: 'Friend',
            },{
              first_name: 'String',
              last_name: 'String',
              email: 'reference@example.com',
              phone_number: 'String',
              relationship: 'Friend',
            },
          ]
        }
      }
    end

    initialize_with { ActiveSupport::HashWithIndifferentAccess.new(attributes[:body]) }
  end
end
