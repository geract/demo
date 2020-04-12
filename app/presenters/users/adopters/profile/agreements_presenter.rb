class Users::Adopters::PetApplications::AgreementsPresenter
  def initialize(adopter)
    @application = adopter.application
  end

  def response
    { application: { 
        home_visit_agreement: application.home_visit_agreement,
        adoption_fee_agreement: application.adoption_fee_agreement,
      }
    }
  end

  private

  attr_reader :application
end
