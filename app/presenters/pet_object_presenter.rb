class PetObjectPresenter
  def self.to_json(pet)
    {
      id: pet.id,
      name: pet.name,
      sex: pet.sex,
      breed: pet.breed,
      age: pet.age,
      location: pet.location,
      size: pet.size,
      images: pet.images_url,
      slug: pet.slug,
      source: pet.source
    }
  end
end
