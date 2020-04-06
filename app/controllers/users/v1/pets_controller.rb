class Users::V1::PetsController < Users::BaseController
  def index
    filters = filters_params.merge({ provider: 'RescueOrganization' })
    pets = Pet::Search.perform(filters)

    render json: { pets: Pets::IndexPresenter.new(pets) }, status: :ok
  end

  def show
    filters = filters_params.merge({ provider: 'RescueOrganization', id: params[:id] })
    pet = Pet::Search.perform(filters).first
    
    if pet
      render json: { pet: Pets::ShowPresenter.new(pet) }, status: :ok
    else
      render status: 404
    end
  end

  private

  def filters_params
    return {} unless params[:filters]

    params.require(:filters).permit(:sex, :age, :size, :zipCode, :radius, :breed)
  end
end
