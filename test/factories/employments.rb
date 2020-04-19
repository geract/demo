FactoryBot.define do
  factory :employment do
    status { "Self-Employed" }
    years { "1-2 years" }
    company { "Unemployed" }
    pet_costs { "123" }
    association(:address, factory: :adopter_address)
  end
end
