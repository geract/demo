module Rescuers
  class PetApplications::IndexPresenter
    def initialize(pet_applications)
      @pet_applications = pet_applications
    end

    def as_json(*)
      pet_applications.map do |application|
        {
          pet: Rescuers::PetPresenter.new(application.pet).short_response,
          total_applications: 'Count',
          days_listed: 'TBD',
          date_listed: 'TBD'
        }
      end
    end

    private

    attr_reader :pet_applications
  end
end
