class Users::Adopters::Profile::ReferencesPresenter
  def initialize(adopter)
    @profile = adopter.profile
    @references = profile.references
  end

  def response
    { profile: { 
        id: profile.id,
        references_attributes: profile_references
      }
    }
  end

  private

  attr_reader :references, :profile

  def profile_references
    references.map do |reference|
      ::ReferencePresenter.new(reference)
    end
  end
end
