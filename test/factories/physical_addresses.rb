FactoryBot.define do
  factory :physical_address do
    name { "petparent" }
    address { "5th. Avenue" }
    city { "Manhattan" }
    state { "New York" }
    zip_code { "99923" }
    main_location { true }
    organization
  end
end
