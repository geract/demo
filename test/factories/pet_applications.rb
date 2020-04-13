FactoryBot.define do
  factory :pet_application do
    state { "MyString" }

    after :build do |pet_application|
      adopter = build(:adopter)
      pet_application.adopter_profile = adopter.profile
      pet_application.pet = build(:pet, :complete)
    end
  end
end
