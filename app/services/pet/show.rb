# Note we have to use this in v1/pets and v1/rescuers/pets
# but we need to refactor it first

class Pet::Show
  class << self
    def perform(friendly_id)
      @friendly_id = friendly_id
      @pet = friendly_find_pet

      # Move this to a presenter
      return [not_found_response, :not_found] unless pet
      return [archived_response, :gone] if pet.archived?
      return [success_response, :ok]
    end

    private

    attr_reader :friendly_id, :pet

    def friendly_find_pet
      begin
        Pet.friendly.find(friendly_id)
      rescue(ActiveRecord::RecordNotFound)
        nil
      end
    end

    def not_found_response
      {pet: {}, 
       errors: []}
    end

    def archived_response
      {pet: {}, 
       errors: ["#{pet.name} is no longer available. Look for more pets like #{pet.name}"]}
    end

    def success_response
      {pet: pet,
       errors: []}
    end
  end
end
