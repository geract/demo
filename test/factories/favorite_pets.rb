FactoryBot.define do
  factory :favorite_pet do
    pet      { build(:pet) } 
    adopter  { build(:adopter) }
  end
end