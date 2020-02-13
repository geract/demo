class PetSearch
  class << self
    def perform(*args)
      Pet.all
    end
  end
end