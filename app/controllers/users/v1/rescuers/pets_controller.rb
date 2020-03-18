class Users::V1::Rescuers::PetsController < Users::V1::Rescuers::BaseController
  def create
    pet = Pet.new(pet_params)
    pet.added_by = current_user
    pet.organization = current_user.organization

    if pet.save
      render json: { pet: Rescuers::Pets::ShowPresenter.new(pet) }
    else
      render json: { pet: Rescuers::Pets::ShowPresenter.new(pet), errors: pet.errors.full_messages }, status: :bad_request
    end
  end

  def update
    pet = current_user.organization.pets.friendly.find(params[:id])

    if pet.update(pet_params)
      render json: { pet: Rescuers::Pets::ShowPresenter.new(pet) }
    else
      render json: { pet: Rescuers::Pets::ShowPresenter.new(pet), errors: pet.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    pet = Pet::Search.perform(organization_id: current_user.organization.id,
                               slug: params[:id]).first

    if pet
      render json: { pet: Rescuers::Pets::ShowPresenter.new(pet) }
    else
      render json: {}, status: :not_found
    end
  end

  def index
    pets = Pet::Search.perform(organization_id: current_user.organization.id,
                               status: [:published, :archived, :adopted])

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
