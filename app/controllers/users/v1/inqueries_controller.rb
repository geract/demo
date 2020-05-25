class Users::V1::InqueriesController < Users::BaseController
  def create
    inquery = Inquery.new(inquery_params)

    if inquery.save
      head :created
    else
      render json: { errors: inquery.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def inquery_params
    params.require(:inquery).permit(:first_name, :last_name, :phone_number, :email, :city, :state, :reasons, :pet_id)
  end
end
