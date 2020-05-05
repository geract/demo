module Rescuers
  class Pets::PetApplications::IndexPresenter
    def initialize(pet_applications)
      @pet_applications = pet_applications
    end

    def as_json(*)
      pet_applications.map do |application|
        {
          id: application.id,
          favorite: application.favorite,
          adopter: Users::Adopters::ProfilePresenter.new(application.adopter_profile).short_response,
          created_at: application.created_at
        }
      end
    end

    private

    attr_reader :pet_applications
  end
end
