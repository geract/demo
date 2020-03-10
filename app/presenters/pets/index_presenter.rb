class Pets::IndexPresenter
  def initialize(pets)
    @pets = pets
  end

  def as_json(*)
    pets.map{ |pet| PetPresenter.new(pet).response }
  end

  private

  attr_reader :pets
end