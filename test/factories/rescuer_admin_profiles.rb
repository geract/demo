FactoryBot.define do
  factory :rescuer_admin_profile do
    first_name         { 'Juan' }
    last_name          { 'Rescuer' }
    phone              { '888999222' }
    title              { 'dev' }

    trait :complete do
      admin       { build(:rescuer_admin) }
      organization  { build(:organization) }
    end
  end
end