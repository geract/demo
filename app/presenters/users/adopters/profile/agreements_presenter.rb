class Users::Adopters::Profile::AgreementsPresenter
  def initialize(adopter)
    @profile = adopter.profile
  end

  def as_json(*)
    { profile: { 
        id: profile.id,
        home_visit_agreement: profile.home_visit_agreement,
        adoption_fee_agreement: profile.adoption_fee_agreement,
      }
    }
  end

  private

  attr_reader :profile
end
