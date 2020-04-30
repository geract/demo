module Rescuers
  class Pets::PetApplications::IndexPresenter
    def initialize(pet_applications)
      @pet_applications = pet_applications
    end

    def as_json(*)
      pet_applications.map do |application|
        {
          adopter: Users::Adopters::ProfilePresenter.new(application.adopter_profile).short_response
        }
      end
    end

    private

    attr_reader :pet_applications
  end
end
