class Pet::UpdateStatusBulk
  class << self
    def perform(pet_ids, status, **conditionals)
      return [[], []] if pet_ids.blank?

      @pet_ids = pet_ids.map(&:to_i)
      @status = status
      @conditionals = conditionals

      update
    end
    
    private
    
    attr_reader :status, :pet_ids, :conditionals
    
    def update
      pets_results = []
      pets_errors = []
      where_conditionals = conditionals.merge(id: pet_ids)

      Pet.where(where_conditionals).find_in_batches(batch_size: 20) do |pets|
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
