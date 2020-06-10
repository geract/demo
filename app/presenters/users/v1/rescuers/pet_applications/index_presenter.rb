class Users::V1::Rescuers::PetApplications::IndexPresenter < BasePresenter
  def as_json(*)
    {
      applications: applications
    }
  end

  private

  def applications
    pets.map do |pet|
      {
        pet: Users::V1::Objects::PetPresenter.to_json(pet),
        total_applications: pet.applications.size,
        date_listed: pet.date_listed,
        new_applications: 0, # To be implemented
        new_messages: 0 # To be implemented
      }
    end
  end
end

