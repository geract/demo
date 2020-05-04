FactoryBot.define do
  factory :pet_application do
    status { "created" }

    after :build do |pet_application|
      adopter = build(:adopter)
      pet_application.adopter_profile = adopter.profile
      pet_application.pet = build(:pet, :complete)
    end
  end

  factory :pet_application_params, class: Hash do
    body do
      { pet_application: {
          pet_id: nil
      }}
    end

    initialize_with { ActiveSupport::HashWithIndifferentAccess.new(attributes[:body]) }
  end
end
