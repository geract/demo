module Rescuers::Surveys
  class Dog
    attr_reader :survey

    def initialize
      @survey = Config.settings_for(:rescuer_surveys)[:dog]
    end
  end
end
