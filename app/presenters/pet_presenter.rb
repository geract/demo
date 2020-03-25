class PetPresenter
  def initialize(pet)
    @pet = pet
  end

  def response
    {
      id: pet.id,
      name: pet.name,
      sex: pet.sex,
      breed: pet.breed,
      age: pet.age,
      location: pet.location,
      image: pet.main_image_url
    }
  end

  private

  attr_reader :pet
end
