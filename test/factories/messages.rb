FactoryBot.define do
  factory :message do
   sender_type { 'Rescuer' }
   message { 'Hello' }
   organization { build(:organization) }
  end
end
