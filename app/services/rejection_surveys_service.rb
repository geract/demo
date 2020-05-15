class RejectionSurveysService
  def self.perform()
    PetApplications::RejectionSurveys.new.options
  end
end
