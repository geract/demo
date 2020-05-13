module Rescuers
  class PetPresenter
    def initialize(pet)
      @pet = pet
    end

    def response
      {
        id: pet.id,
        slug: pet.slug,
        name: pet.name,
        sex: pet.sex,
        breed: pet.breed,
        age: pet.age,
        price: pet.price,
        microchip_provider: pet.microchip_provider,
        microchip_number: pet.microchip_number,
        pet_type: pet.pet_type,
        housed: pet.housed,
        second_breed: pet.second_breed,
        description: pet.description,
        medical_history: pet.medical_history,
        foster_family: pet.foster_family,
        public: pet.public,
        mix_breed: pet.mix_breed,
        personality: pet.personality,
        slug: pet.slug,
        short_url: pet.short_url,
        status: pet.status,
        reason_code: pet.reason_code,
        size: pet.size,
        images: pet.images_url,
      }
    end

    def short_response
      {
        id: pet.id,
        name: pet.name,
        address: 'TBD',
        images: pet.images_url
      }
    end

    private

    attr_reader :pet
  end
end
