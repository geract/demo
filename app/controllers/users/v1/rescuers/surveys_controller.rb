class Users::V1::Rescuers::SurveysController < Users::V1::Rescuers::BaseController
  def index
    survey = Rescuer::SurveyService.perform('Dog')[params[:type].to_sym]
    
    response_with_presenter(survey: survey)
  end
end
