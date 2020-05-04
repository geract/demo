FactoryBot.define do
  factory :adopter_address do
    street_line_1 { '960 Nicolls Lane' }
    street_line_2 { nil }
    city { 'Mountain View' }
    state { 'CA' }
    zip_code { '94043' }
    country { 'United States' }
  end
end
