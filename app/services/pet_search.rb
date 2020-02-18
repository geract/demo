class PetSearch
  def self.perform(**args)
    conditions = args.merge({ animalSpecies: 'Dog' })
    RescueGroups::Animal.where(conditions)
  end
end