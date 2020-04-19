FactoryBot.define do
  factory :co_adopter do
    email              { 'test@coadopter.com' }
    phone_number       { '1223334444' }
    first_name         { 'Co' }
    last_name          { 'Adopter' }
    
    after :build do |adopter_profile|
      adopter_profile.address = build(:adopter_address)
      adopter_profile.employment = build(:employment)
    end
  end
end
