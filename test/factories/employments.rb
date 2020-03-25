FactoryBot.define do
  factory :employment do
    status { "Self-Employed" }
    years { "1-2 years" }
    company { "Unemployed" }
    pet_costs { "123" }

    after :build do |profile|
      profile.address =  build(:adopter_address)
    end
  end
end
