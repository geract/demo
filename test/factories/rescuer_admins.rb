FactoryBot.define do
  factory :rescuer_admin do
    email              { Faker::Internet.email }
    password           { 'TopS3cr3t' }
    type               { 'RescuerAdmin' }
    confirmation_token { Faker::Alphanumeric.alpha(number: 10) }
    uid                { Faker::Internet.email }

    trait :complete do
      profile { build(:rescuer_admin_profile, :complete) }
    end
  end
end
