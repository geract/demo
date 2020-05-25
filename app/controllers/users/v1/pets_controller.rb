class Users::V1::PetsController < Users::BaseController
  def index
    filters = filters_params.merge({ provider: 'RescueOrganization' })
    pets = SearchPetService.perform(filters)

    response_with_presenter(pets: pets)
  end

  def show
    filters = filters_params.merge({ provider: 'RescueOrganization', id: params[:id] })
    pet = SearchPetService.perform(filters).first
    
    if pet
      response_with_presenter(pet: pet)
    else
      render status: 404
    end
  end

  private

  def filters_params
    return {} unless params[:filters]

    params.require(:filters).permit(:sex, :age, :size, :zipCode, :radius, :breed, :organization_id, :page, :limit)
  end
end
