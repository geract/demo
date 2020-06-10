class Users::V1::Objects::RescuerPetPresenter
  def self.to_json(pet)
    base = Users::V1::Objects::PetPresenter.to_json(pet)

    base.merge({
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
        short_url: pet.short_url,
        status: pet.status,
        reason_code: pet.reason_code,
      })
  end
end