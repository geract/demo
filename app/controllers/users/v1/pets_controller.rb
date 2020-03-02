class Users::V1::PetsController < Users::BaseController
  def index
    pets = Pet::Search.perform(status: :published)

    render json: { pets: pets }, status: 200
  end

  def show
    pet = Pet::Search.perform(slug: params[:id],
                               status: :published)

    if pet
      render json: { pet: pet }, status: 200
    else
      render status: 404
    end
  end
end
