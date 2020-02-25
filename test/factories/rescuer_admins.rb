FactoryBot.define do
  factory :rescuer_admin do
    first_name         { "Juan" }
    email              { "rescuer@pph.com" }
    password           { "TopS3cr3t" }
    type               { "RescuerAdmin" }
    confirmation_token { "token123" }
    uid                { "rescuer@pph.com" }
  end
end
