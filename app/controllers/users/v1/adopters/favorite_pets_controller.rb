class Users::V1::Adopters::FavoritePetsController < Users::V1::Adopters::BaseController
  def create
    pet = Pet.find(params[:id])

    if current_user.favorite_pets << pet
      head :ok
    else
      head :unprocessable_entity
    end
  end
end
