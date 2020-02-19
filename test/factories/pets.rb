FactoryBot.define do
  factory :pet do
    age { 'Puppy' }
    breed { 'Shiba Inu' }
    description { 'Happy dog' }
    housed { 'Shelter' }
    name { 'Doggo' }
    price { 100.00 }
    sex { 'Male' }
    size { 'Large' }
    personality {
      {
        good_with_children: true,
        good_with_dogs: true,
        good_with_cats: true
      }
    }
  end
end
