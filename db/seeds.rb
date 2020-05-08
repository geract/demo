legal_address = LegalAddress.new(name: "PetParent", address: "5th. Avenue", city: "Manhattan", state: "New York", zip_code: "99923", main_location: true)
organization = Organization.create(name: "PetParent", email: "pph@pph.com", phone: "1231231231", director: "Dana", legal_address: legal_address)

adopter = Adopter.new(email: "adopter@pph.com", password: "Topsecr3t")
adopter.confirm
adopter.save

rescuer_admin = RescuerAdmin.new(email: "ra1@pph.com", password: "Topsecr3t", password_confirmation: "Topsecr3t")
rescuer_admin.build_profile(first_name: "Juan", last_name: "Rescuer", phone: "6630671333", title: "dev", organization: organization)
rescuer_admin.save

Pet.create(age: 1, breed: "Shiba Inu", description: "Happy dog", housed: "Shelter", name: "Doggo", added_by: rescuer_admin,
            price: 100, sex: "Male", size: "Large", status: "created", location: "Boonton, NJ", organization: organization)
