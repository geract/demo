class Users::V1::Rescuers::PetApplications::RejectionSurveysController < Users::V1::Rescuers::BaseController
  def index
    render json: RejectionSurveys::IndexPresenter.new(options)
  end

  private

  def options
    @options ||= RejectionSurveysService.perform()
  end
end
