FactoryBot.define do
  factory :rescuer do
    first_name         { 'Juan' }
    last_name          { 'Rescuer' }
    email              { "#{first_name}@pph.com" }
    password           { 'TopS3cr3t' }
    type               { 'Rescuer' }
    confirmation_token { "#{first_name}1234" }
    uid                { 'rescueruser@pph.com' }
    phone              { '888999222' }
    status             { 'created' }
  end
end
