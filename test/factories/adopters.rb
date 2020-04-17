FactoryBot.define do
  factory :adopter do
    email              { Faker::Internet.email }
    password           { 'TopS3cr3t' }
    type               { 'Adopter' }
    confirmation_token { Faker::Alphanumeric.alpha(number: 10) }
    uid                { Faker::Internet.email }

    after :build do |adopter|
      adopter.profile = build(:adopter_profile, adopter: adopter)
    end

    trait :without_pet_info do
      after :build do |adopter|
        adopter.profile = build(:adopter_profile, pet_info: nil, adopter: adopter)
      end
    end

    trait :with_personal_info do
      after :build do |adopter|
        adopter.profile = build(:adopter_profile, :personal_info, adopter: adopter)
      end
    end

    trait :with_co_adopter do
      after :build do |adopter|
        adopter.profile = build(:adopter_profile, :personal_co_adopter, adopter: adopter)
      end
    end

    trait :with_personal_final do
      after :build do |adopter|
        adopter.profile = build(:adopter_profile, :personal_final, adopter: adopter)
      end
    end

    trait :with_profile_home do
      after :build do |adopter|
        adopter.profile = build(:adopter_profile_with_home, adopter: adopter)
      end
    end

    trait :with_profile_lifestyle do
      after :build do |adopter|
        adopter.profile = build(:adopter_profile_with_lifestyle, adopter: adopter)
      end
    end

    trait :with_profile_agreements do
      after :build do |adopter|
        adopter.profile = build(:adopter_profile_with_agreements, adopter: adopter)
      end
    end

    trait :with_profile_references do
      after :build do |adopter|
        adopter.profile = build(:adopter_profile_with_references, adopter: adopter)
      end
    end

    trait :with_profile_completed do
      after :build do |adopter|
        adopter.profile = build(:adopter_profile_completed, adopter: adopter)
      end
    end
  end
end
