FactoryBot.define do
  factory :rescuer do
    email              { Faker::Internet.email }
    password           { 'TopS3cr3t' }
    type               { 'Rescuer' }
    confirmation_token { Faker::Alphanumeric.alpha(number: 10) }
    uid                { Faker::Internet.email }
    status             { 'created' }

    trait :complete do
      profile { build(:rescuer_profile, :complete) }
    end
  end
end
