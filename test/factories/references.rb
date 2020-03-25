FactoryBot.define do
  factory :reference do
    first_name      { 'Juanito' }
    last_name       { 'Bananas' }
    phone_number    { '3157863467' }
    relationship    { 'Sibling' }
    email           { 'juanito@bananas.com' }
    association(:application, factory: :pet_application)
  end

  factory :references_params, class: Hash do
    body do
      { application: { 
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
