class Pet::UpdateBulk
  class << self
    def perform(pet_ids, status)
      return [[], []] if pet_ids.blank?

      @pet_ids = pet_ids.map(&:to_i)
      @status = status

      update
    end
    
    private
    
    attr_reader :status, :pet_ids
    
    def update
      pets_results = []
      pets_errors = []
      
      Pet.where(id: pet_ids).find_in_batches(batch_size: 20) do |pets|
        pets.each do |pet|
          pets_results << pet
          next if Pet::UpdateStatus.perform(pet, status) && pet.valid?

          pets_errors << { id: pet.id, errors: pet.errors.messages }
        end
      end
      [pets_results, pets_errors]
    end
  end
end
