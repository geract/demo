FactoryBot.define do
  factory :adopter_profile do
    first_name { "Ale" }
    last_name { "Jandra" }
    pronoun { "She" }
    family_status { "Single" }
    birthday { "2020-03-14" }
    phone_number { "1234567890" }

    after :build do |profile|
      profile.address = build(:adopter_address)
      profile.employment = build(:employment)
    end
  end

  factory :co_adopter_profile, class: 'AdopterProfile' do
    first_name { "Gibran" }
    last_name { "GeDiez" }
    pronoun { "He" }
    family_status { "Single" }
    birthday { "2020-01-01" }
    phone_number { "1234567890" }

    after :build do |profile|
      profile.address = build(:adopter_address)
      profile.employment = build(:employment)
    end
  end
end
