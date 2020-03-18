module Rescuers
  class Pets::IndexPresenter
    def initialize(pets)
      @pets = pets
    end

    def as_json(*)
      pets.map{|pet| Rescuers::PetPresenter.new(pet).response }
    end

    private

    attr_reader :pets
  end
end
