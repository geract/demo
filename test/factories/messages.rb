FactoryBot.define do
  factory :message do
   senderable_type { 'Rescuer' }
   message { 'Hello' }
  end
end
