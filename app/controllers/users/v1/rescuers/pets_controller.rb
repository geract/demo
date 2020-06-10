class Users::V1::Rescuers::PetsController < Users::V1::Rescuers::BaseController
  def create
    pet = Pet.new(pet_params)

    if SavePetService.perform(pet, current_user)
      head :ok
    else
      render json: { errors: pet.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    pet = current_user.organization.pets.friendly.find(params[:id])

    if Rescuer::UpdatePetService.perform(pet, pet_params)
      head :ok
    else
      render json: { errors: pet.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    search_filters = { organization_id: current_user.organization.id }
    pet = SearchPetService.perform(slug: params[:id], **search_filters).first

    if pet
      if pet.archived?
        render json: { errors: ["#{pet.name} is no longer available. Look for more pets like #{pet.name}"] }, status: :gone
      else
        response_with_presenter(pet: pet)
      end
    else
      render json: {}, status: :not_found
    end
  end

  def index
    pets = SearchPetService.perform(organization_id: current_user.organization.id)

    response_with_presenter(pets: pets)
  end

  private

  def pet_params
    params.require(:pet).permit(:name,
                        :price,
                        :microchip_provider,
                        :microchip_number,
                        :housed,
                        :breed,
                        :second_breed,
                        :sex,
                        :size,
                        :age,
                        :description,
                        :medical_history,
                        :foster_family,
                        :public,
                        :mix_breed,
                        :location,
                        personality: {},
                        images: []
                        )
  end
end
