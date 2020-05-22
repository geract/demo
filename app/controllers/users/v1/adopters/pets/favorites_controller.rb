class Users::V1::Adopters::Pets::FavoritesController < Users::V1::Adopters::BaseController
  def index
    pets = current_user.favorite_pets

    render json: V1::Adopters::FavoritePets::IndexPresenter.new(pets), status: :ok
  end

  def create
    pet = SearchPetService.perform(slug: params[:pet_id]).first
    favorite = current_user.favorites.build(pet: pet)

    if favorite.save
      head :ok
    else
      render json: favorite.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    pet = SearchPetService.perform(slug: params[:pet_id]).first
    favorite = current_user.favorites.find_by(pet_id: pet.id)

    if favorite.destroy
      head :ok
    else
      render json: favorite.errors.full_messages, status: :unprocessable_entity
    end
  end
end
