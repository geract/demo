FactoryBot.define do
  factory :rescuer do
    name               { "Juan" }
    email              { "rescuer@pph.com" }
    password           { "TopS3cr3t" }
    type               { "Rescuer" }
    confirmation_token { "token123" }
    uid                { "rescueruser@pph.com" }
  end
end
