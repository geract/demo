FactoryBot.define do
  factory :adopter do
    email              { Faker::Internet.email }
    password           { 'TopS3cr3t' }
    type               { 'Adopter' }
    confirmation_token { Faker::Alphanumeric.alpha(number: 10) }
    uid                { Faker::Internet.email }

    after :build do |adopter|
      adopter.profile = build(:adopter_profile)
    end

    trait :without_pet_info do
      after :build do |adopter|
        adopter.profile = build(:adopter_profile, pet_info: nil)
      end
    end

    trait :with_application_personal_info do
      after :build do |adopter|
        adopter.profile = build(:adopter_profile, :personal_info)
      end
    end

    trait :with_application_co_adopter do
      after :build do |adopter|
        adopter.profile = build(:adopter_profile, :personal_co_adopter)
      end
    end

    trait :with_application_personal_co_adopter do
      after :build do |adopter|
        adopter.profile = build(:adopter_profile, :personal_co_adopter)
      end
    end

    trait :with_application_personal_final do
      after :build do |adopter|
        adopter.profile = build(:adopter_profile, :personal_final)
      end
    end

    trait :with_application_home do
      after :build do |adopter|
        adopter.profile = build(:adopter_profile, :home)
      end
    end

    trait :with_application_lifestyle do
      after :build do |adopter|
        adopter.profile = build(:adopter_profile, :lifestyle)
      end
    end

    trait :with_application_completed do
      after :build do |adopter|
        adopter.profile = build(:adopter_profile, :completed)
      end
    end

    trait :with_application_agreements do
      after :build do |adopter|
        adopter.profile = build(:adopter_profile)
      end
    end

    trait :with_application_references do
      after :build do |adopter|
        adopter.profile = build(:adopter_profile)
      end
    end

    trait :with_completed_application do
      after :build do |adopter|
        adopter.profile = build(:adopter_profile)
      end
    end
  end

  factory :co_adopter, class: 'Adopter' do
    email              { 'test@coadopter.com' }
    password           { 'TopS3cr3t' }
    type               { 'Adopter' }
    confirmation_token { Faker::Alphanumeric.alpha(number: 10) }
    uid                { 'test@coadopter.com' }

    after :build do |adopter|
      adopter.profile = build(:co_adopter_profile)
    end
  end
end
