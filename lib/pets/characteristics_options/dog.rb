module Pets::CharacteristicsOptions
  class Dog
    attr_reader :options

    def initialize
      @options = Config.settings_for(:pet)['dog']
    end
  end
end
