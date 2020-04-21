class Users::V1::Rescuers::PetApplicationsController < Users::V1::Rescuers::BaseController
  def index
    @pets_count = PetApplication.select(:pet_id).group(:pet_id).count
    
    @pets = Shared::SearchPetApplication.perform(filters_params.merge(id: @pets_count.keys))

    render json: {applications: Rescuers::PetApplications::IndexPresenter.new(@pets, options_for_pet_index)}, status: :ok
  end

  private

  def filters_params
    return {} unless params[:filters]

    params.require(:filters).permit(:status)
  end

  def options_for_pet_index
    @pets_count.reduce(Hash.new) do |hash, (pet_id, pet_count)|
      date_listed = @pets.find {|pet| pet.id == pet_id }.created_at
    
      hash[pet_id] = {
        total_applications: pet_count,
        days_listed: (Time.zone.now - date_listed).to_i / 1.day,
        date_listed: date_listed
      }
      hash
    end
  end
end
