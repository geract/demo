FactoryBot.define do
  factory :rescuer do
    first_name         { "Juan" }
    last_name          { "Rescuer" }
    email              { "rescueruser@pph.com" }
    password           { "TopS3cr3t" }
    type               { "Rescuer" }
    confirmation_token { "token1234" }
    uid                { "rescueruser@pph.com" }
    phone              { "888999222" }
  end
end
