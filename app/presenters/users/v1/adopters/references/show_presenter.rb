class Users::V1::Adopters::References::ShowPresenter < BasePresenter
  def as_json(*)
    { 
      profile: { 
        id: profile.id,
        references_attributes: references_attributes
      }
    }
  end

  def references_attributes
    profile.references.map do |reference|
      Users::V1::Objects::Adopters::ReferencePresenter.to_json(reference)
    end
  end
end
