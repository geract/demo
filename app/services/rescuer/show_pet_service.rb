class Rescuer::ShowPetService
  class << self
    def perform(pet)
      @pet = pet

      return [archived_response, :gone] if pet.archived?
      return [success_response, :ok]
    end

    private

    attr_reader :pet

    def archived_response
      {pet: {}, 
       errors: ["#{pet.name} is no longer available. Look for more pets like #{pet.name}"]}
    end

    def success_response
      {pet: Rescuers::Pets::ShowPresenter.new(pet).as_json,
       errors: []}
    end
  end
end
