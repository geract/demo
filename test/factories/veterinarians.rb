FactoryBot.define do
  factory :veterinarian do
    first_name { 'Doctor' }
    last_name { 'Dolittle' }
    phone_number { '2223334445' }
    email { "dr_dolittle@gmail.com" }
    association :address, factory: :adopter_address
  end
end
