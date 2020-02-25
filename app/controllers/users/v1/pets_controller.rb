class Users::V1::PetsController < Users::BaseController
  def new
  end

  def create
    pet = Pet.new(pet_params)

    if pet.save
      render json: { pet: pet }
    else
      render json: { pet: pet, errors: pet.errors.full_messages }, status: :bad_request
    end
  end

  def update
    pet = Pet.friendly.find(params[:id])

    if pet.update(pet_params)
      render json: { pet: pet }
    else
      render json: { pet: pet, errors: pet.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    response, status = Pet::Show.perform(params[:id])

    render json: response, status: status
  end

  def index
    pets = Pet.not_archived

    render json: {pets: pets}, status: :ok
  end

  def index
    pets = Pet::Search.perform(status: [:published, :archived, :adopted])

    render json: {pets: pets}, status: 200
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
