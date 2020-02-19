module Pets::CharacteristicsOptions
  class Dog
    attr_reader :options

    def initialize
      @options = Rails.application.config_for(:pet)['dog']
    end
  end
end
