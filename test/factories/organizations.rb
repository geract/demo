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
    admin { true }
    legal_address
    physical_address 
  end
end
