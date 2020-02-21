class User::SavePet
  class << self
    def perform(pet)
      @pet = pet
      Pet.transaction do
        saved = pet.save
        saved_callbacks if saved
        saved
      end
    end

    private

    attr_reader :pet

    def saved_callbacks
      ::LinkShortenerJob.perform_later(pet.id)
    end
  end
end
