class Rescuer::UpdatePetService
  class << self
    def perform(pet, params)
      @pet = pet
      @params = params
      prepare_params

      Pet.transaction do
        saved = pet.update(params)
        saved_callbacks if saved
        saved
      end
    end

    private

    attr_reader :pet, :images
    attr_accessor :params

    def prepare_params
      @images = params.delete(:images)
    end

    def saved_callbacks
      pet.images.attach(images)
    end
  end
end
