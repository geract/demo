module Rescuers
  class Pets::ShowPresenter
    def initialize(pet)
      @pet = pet
    end

    def as_json(*)
      Rescuers::PetPresenter.new(pet).response
    end

    private

    attr_reader :pet
  end
end
