FactoryBot.define do
  factory :user do
    name               { "Juan" }
    email              { "user@pph.com" }
    password           { "TopS3cr3t" }
    type               { "User" }
    confirmation_token { "user123" }
  end
end
