class Users::V1::Adopters::AgreementsPresenter::ShowPresenter < BasePresenter
  def as_json(*)
    { 
      profile: { 
        id: profile.id,
        home_visit_agreement: profile.home_visit_agreement,
        adoption_fee_agreement: profile.adoption_fee_agreement,
      }
    }
  end
end
