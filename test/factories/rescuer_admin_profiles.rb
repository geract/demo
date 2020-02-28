FactoryBot.define do
  factory :rescuer_admin_profile do
    first_name         { 'Juan' }
    last_name          { 'Rescuer' }
    phone              { '888999222' }
    title              { 'dev' }
  end

  trait :complete do
    rescuer { build(:rescuer) }
  end
end