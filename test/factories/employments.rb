FactoryBot.define do
  factory :employment do
    status { "Employed" }
    years { "1-2 years" }
    company { "PetParent" }
    pet_costs { "1200" }
    association(:address, factory: :adopter_address)
  end
end
