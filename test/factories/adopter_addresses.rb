FactoryBot.define do
  factory :adopter_address do
    street_line_1 { 'Street Line #1' }
    street_line_2 { nil }
    city { 'San Francisco' }
    state { 'CA' }
    zip_code { '11111' }
    country { 'United States' }
  end
end
