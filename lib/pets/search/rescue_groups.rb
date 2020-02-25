class Pets::Search::RescueGroups
  attr_accessor :filters

  def initialize(**args)
    @filters = args.merge({ animalSpecies: 'Dog' })
  end
  
  def execute
    RescueGroups::Animal.where(filters)
  end
end
