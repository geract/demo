module Rescuers
  class PetApplications::IndexPresenter
    def initialize(pets)
      @pets = pets
    end

    def as_json(*)
      pets.map do |pet|
        {
          pet: Rescuers::PetPresenter.new(pet).short_response,
        }.merge(additional_fields_for(pet))
      end
    end

    private

    attr_reader :pets, :options

    def additional_fields_for(pet)
      {
        total_applications: pet.applications.size,
        date_listed: pet.date_listed,
        new_applications: 0 # To be implemented
      }
    end
  end
end
