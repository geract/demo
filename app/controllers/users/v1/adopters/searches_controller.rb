class Users::V1::Adopters::SearchesController < Users::V1::Adopters::BaseController
  def update
    current_user.search = search_params

    if current_user.save
      head :ok
    else
      head :unprocessable_entity
    end
  end

  private

  def search_params
    params.require(:search).permit(:sex, :age, :size, :breed, :zipcode)
  end
end
