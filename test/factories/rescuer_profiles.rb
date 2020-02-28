FactoryBot.define do
  factory :rescuer_profile do
    first_name         { 'Juan' }
    last_name          { 'Rescuer' }
    phone              { '888999222' }
    title              { 'dev' }

    trait :complete do
      rescuer       { build(:rescuer) }
      organization  { build(:organization) }
    end
  end
end
