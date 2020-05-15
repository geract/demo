class Users::V1::Rescuers::PetsController < Users::V1::Rescuers::BaseController
  def create
    pet = Pet.new(pet_params)

    if SavePetService.perform(pet, current_user)
      render json: { pet: Rescuers::Pets::ShowPresenter.new(pet) }
    else
      render json: { pet: Rescuers::Pets::ShowPresenter.new(pet), errors: pet.errors.full_messages }, status: :bad_request
    end
  end

  def update
    pet = current_user.organization.pets.friendly.find(params[:id])

    if Rescuer::UpdatePetService.perform(pet, pet_params)
      render json: { pet: Rescuers::Pets::ShowPresenter.new(pet) }
    else
      render json: { pet: Rescuers::Pets::ShowPresenter.new(pet), errors: pet.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    search_filters = { organization_id: current_user.organization.id }
    pet = SearchPetService.perform(slug: params[:id], **search_filters).first

    if pet
      response, status = Rescuer::ShowPetService.perform(pet)
      render json: response, status: status
    else
      render json: {}, status: :not_found
    end
  end

  def index
    pets = SearchPetService.perform(organization_id: current_user.organization.id)

    render json: { pets: Rescuers::Pets::IndexPresenter.new(pets) }, status: :ok
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
                        personality: {},
                        images: []
                        )
  end
end
