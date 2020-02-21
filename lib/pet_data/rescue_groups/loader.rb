module PetData::RescueGroups
  class Loader
    PET_TYPES = %w(Dog).freeze

    def perform
      data = PetData::RescueGroups::Formater.new(pets).perform

      Pet.transaction do
        Pet.where(external_type: 'RescueGroups').delete_all
        Pet.import(data)
      end
    end

    private

    def pets
      @pets ||= RescueGroups::Animal.where(animalSpecies: PET_TYPES)
    end
  end
end
