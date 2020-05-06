FactoryBot.define do
  factory :pet do
    age               { 'Puppy' }
    breed             { 'Shiba Inu' }
    description       { 'Happy dog' }
    housed            { 'Shelter' }
    name              { 'Doggo' }
    price             { 100.00 }
    sex               { 'Male' }
    size              { 'Large' }
    status            { 'created' }
    location          { 'Boonton, NJ' }
    personality {
      {
        good_with_children: true,
        good_with_dogs: true,
        good_with_cats: true
      }
    }

    trait :complete do
      organization   { build(:organization, :complete) }
      added_by       { build(:rescuer, :complete) }
    end
  end
end
