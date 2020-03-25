FactoryBot.define do
  factory :pet_application do
    adopter
    home_visit_agreement { true }
    adoption_fee_agreement { true }

    trait :with_co_adopter do
      association(:co_adopter, factory: :adopter, email: 'co_adopter@example.com')

      after :build do |application|
        application.co_adopter = build(:adopter)
      end
    end

    trait :with_veterinarian do
      veterinarian
    end

    trait :with_agreements do
      state { 'agreements' }
    end

    trait :with_references do
      state { 'add_references' }
    end

    trait :completed do
      state { 'completed' }
    end
  end
end
# 
