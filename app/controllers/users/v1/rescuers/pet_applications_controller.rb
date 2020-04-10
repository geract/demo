class Users::V1::Rescuers::PetApplicationsController < Users::V1::Rescuers::BaseController
  def index
    pets_count = PetApplication.select(:pet_id).group(:pet_id).count
    pets = Pet.where(id: pets_count.keys)

    # Dirty trick to get required Data for 193
    options = pets_count.reduce(Hash.new) do |hash, (pet_id, pet_count)|
      date_listed = pets.find {|pet| pet.id == pet_id }.created_at

      hash[pet_id] = {
        total_applications: pet_count,
        days_listed: (Time.zone.now - date_listed).to_i / 1.day,
        date_listed: date_listed
      }
      hash
    end

    render json: {applications: Rescuers::PetApplications::IndexPresenter.new(pets, options)}, status: :ok
  end
end
