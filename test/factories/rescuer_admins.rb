FactoryBot.define do
  factory :rescuer_admin do
    email              { 'rescuer@pph.com' }
    password           { 'TopS3cr3t' }
    type               { 'RescuerAdmin' }
    confirmation_token { 'token123' }
    uid                { 'rescuer@pph.com' }

    trait :complete do
      profile { build(:rescuer_admin_profile) }
    end
  end
end
