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

    trait :with_application_personal_info do
      after :build do |adopter|
        adopter.application = build(:pet_application, applicationable: build(:pet_application_dog, :personal_info))
      end
    end

    trait :with_application_co_adopter do
      after :build do |adopter|
        adopter.application = build(:pet_application, :with_co_adopter, applicationable: build(:pet_application_dog, :personal_co_adopter))
      end
    end

    trait :with_application_personal_co_adopter do
      after :build do |adopter|
        adopter.application = build(:pet_application, applicationable: build(:pet_application_dog, :personal_co_adopter))
      end
    end

    trait :with_application_personal_final do
      after :build do |adopter|
        adopter.application = build(:pet_application, applicationable: build(:pet_application_dog, :personal_final))
      end
    end

    trait :with_application_home do
      after :build do |adopter|
        adopter.application = build(:pet_application, applicationable: build(:pet_application_dog, :home))
      end
    end

    trait :with_application_lifestyle do
      after :build do |adopter|
        adopter.application = build(:pet_application, applicationable: build(:pet_application_dog, :lifestyle))
      end
    end

    trait :with_application_completed do
      after :build do |adopter|
        adopter.application = build(:pet_application, applicationable: build(:pet_application_dog, :completed))
      end
    end

    trait :with_application_agreements do
      after :build do |adopter|
        adopter.application = build(:pet_application, :with_agreements, applicationable: build(:pet_application_dog, :completed))
      end
    end

    trait :with_application_references do
      after :build do |adopter|
        adopter.application = build(:pet_application, :with_references, applicationable: build(:pet_application_dog, :completed))
      end
    end

    trait :with_completed_application do
      after :build do |adopter|
        adopter.application = build(:pet_application, :completed, applicationable: build(:pet_application_dog, :completed))
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
