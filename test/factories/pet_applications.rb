FactoryBot.define do
  factory :pet_application do
    status          { "created" }
    adopter_profile { build(:adopter_profile_completed_with_adopter) }
    pet             { build(:pet, :complete) }
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
