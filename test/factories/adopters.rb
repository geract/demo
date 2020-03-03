FactoryBot.define do
  factory :adopter do
    email              { Faker::Internet.email }
    password           { 'TopS3cr3t' }
    type               { 'Adopter' }
    confirmation_token { Faker::Alphanumeric.alpha(number: 10) }
    uid                { Faker::Internet.email }
  end
end
