class CharacteristicsOptionsService
  # Perform will execute Pets::CharacteristicsOptions::Dog.new.options
  # if no type is present
  def self.perform(type = 'dog')
    "Pets::CharacteristicsOptions::#{type.classify}".constantize.new.options
  end
end
