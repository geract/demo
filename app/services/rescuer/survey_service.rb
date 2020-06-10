class Rescuer::SurveyService
  def self.perform(type)
    "Rescuers::Surveys::#{type.classify}".constantize.new.survey
  end
end