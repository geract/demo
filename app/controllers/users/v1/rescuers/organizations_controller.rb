class Users::V1::Rescuers::OrganizationsController < Users::V1::Rescuers::BaseController
  load_and_authorize_resource

  def update
    @organization = current_user.organization

    unless @organization.update(organization_params)
      render json: { errors: @organization.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @organization = current_user.organization

    unless @organization
      render status: :not_found
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name,
                                         :director,
                                         :description,
                                         :facebook,
                                         :twitter,
                                         :instagram,
                                         :url,
                                         :phone,
                                         :sheltered,
                                         :foster_based,
                                         :logo,
                                         legal_address_attributes: organization_addresses_attributes,
                                         physical_addresses_attributes: organization_addresses_attributes)
  end

  def organization_addresses_attributes
    %i(id name address city state zip_code main_location)
  end
end
