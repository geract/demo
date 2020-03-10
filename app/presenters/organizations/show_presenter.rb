class Organizations::ShowPresenter
  def initialize(pets, organization)
    @pets = pets
    @organization = organization
  end

  def as_json(*)
    {
      id: organization['orgID'],
      name: organization['orgName'],
      description: organization['orgAbout'],
      webUrl: organization['orgWebsiteUrl'],
      email: organization['orgEmail'],
      code: organization['orgPostalcode'],
      address: "#{organization['orgAddress']}, #{organization['orgCity']}, #{organization['orgCountry']}",
      pets: pets.map{ |pet| PetPresenter.new(pet).response }
    }
  end

  private

  attr_reader :pets, :organization
end