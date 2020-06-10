class Users::V1::PetsController < Users::BaseController
  def index
    pets = SearchPetService.perform(filters_params)

    response_with_presenter(pets: pets)
  end

  def show
    pet = SearchPetService.perform(id: params[:id]).first
    
    if pet
      response_with_presenter(pet: pet)
    else
      head :unprocesable_entity
    end
  end

  private

  def filters_params
    return {} unless params[:filters]

    params.require(:filters).permit(:sex, :age, :size, :zipCode, :radius, :breed, :organization_id, :page, :limit)
  end
end
