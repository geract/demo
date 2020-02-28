FactoryBot.define do
  factory :rescuer do
    email              { 'rescueruser@pph.com' }
    password           { 'TopS3cr3t' }
    type               { 'Rescuer' }
    confirmation_token { 'token1234' }
    uid                { 'rescueruser@pph.com' }
    status             { 'created' }

    trait :complete do
      profile { build(:rescuer_profile, :complete) }
    end
  end
end
