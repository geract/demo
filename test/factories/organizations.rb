FactoryBot.define do
  factory :organization do
    name          { "petparent" }
    director      { "Jonh Doe" }
    description   { "Match with a pet" }
    facebook      { "facebook" }
    twitter       { "twitter" }
    sheltered     { true }
    foster_based  { false }
    url           { "petparent.com" }
    email         { "31212345" }
    phone         { "31212345" }

    trait :complete do
      physical_addresses    { build_list(:physical_address, 1) }
      legal_address         { build(:legal_address) }
      rescuer_profiles      { build_list(:rescuer_profile, 1) }
      rescuer_admin_profile { build(:rescuer_admin_profile, :complete) }
    end
  end
end
