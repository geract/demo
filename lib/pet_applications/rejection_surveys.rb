module PetApplications
  class RejectionSurveys
    attr_reader :options

    def initialize
      @options = Config.settings_for(:rejection_surveys)['questions']
    end
  end
end
