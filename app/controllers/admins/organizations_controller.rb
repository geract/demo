class Admins::OrganizationsController < Admins::BaseController
  def new
    @organization = Organization.new
    @organization.physical_addresses.build
    @organization.build_legal_address
  end

  def create
    if create_organization
      redirect_to admins_organization_path(@organization)
    else
      render 'organizations/new'
    end
  end

  def show
    @organization = Organization.find(params[:id])
  end

  private

  def organization_params
    params.require(:organization).permit( :name,
                                          :director,
                                          :description,
                                          :facebook,
                                          :twitter,
                                          :instagram,
                                          :'5013c',
                                          :url,
                                          :email,
                                          :phone,
                                          :sheltered,
                                          :foster_based,
                                          legal_address_attributes: organization_addresses_attributes,
                                          physical_addresses_attributes: organization_addresses_attributes)
  end

  def organization_addresses_attributes
    [:id, :name, :address, :city, :state, :zip_code, :main_location, :type]
  end

  def create_organization
    @organization = Organization.new(organization_params)
    @organization.admin_id = current_admin.id
    @organization.save
  end
end
