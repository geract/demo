FactoryBot.define do
  factory :organization do
    name { "petparent" }
    director { "Jonh Doe" }
    description { "Match with a pet" }
    facebook { "facebook" }
    twitter { "twitter" }
    sheltered { true }
    foster_based { false }
    url { "petparent.com" }
    email { "31212345" }
    admin
    legal_address
    physical_addresses { build_list(:physical_address, 1) }
  end
end
