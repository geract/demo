module Rescuers
  class PetApplications::IndexPresenter
    def initialize(pets, options)
      @pets = pets
      @options = options
    end

    def as_json(*)
      pets.map do |pet|
        {
          pet: Rescuers::PetPresenter.new(pet).short_response,
        }.merge(additional_fields_for(pet.id))
      end
    end

    private

    attr_reader :pets, :options

    def additional_fields_for(pet_id)
      {
        total_applications: options[pet_id][:total_applications],
        days_listed: options[pet_id][:days_listed],
        date_listed: options[pet_id][:date_listed],
        new_applications: 0
      }
    end
  end
end
